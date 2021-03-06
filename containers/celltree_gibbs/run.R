library(jsonlite)
library(readr)
library(dplyr)
library(purrr)

requireNamespace("cellTree")

#   ____________________________________________________________________________
#   Load data                                                               ####

data <- read_rds("/input/data.rds")
params <- jsonlite::read_json("/input/params.json")

#' @examples
#' data <- dyntoy::generate_dataset(unique_id = "test", num_cells = 300, num_features = 300, model = "binary_tree") %>% c(., .$prior_information)
#' params <- yaml::read_yaml("containers/celltree_gibbs/definition.yml")$parameters %>%
#'   {.[names(.) != "forbidden"]} %>%
#'   map(~ .$default)
#' params$tot_iter <- 30 # oveeride for testing

#   ____________________________________________________________________________
#   Infer trajectory                                                        ####

expression <- data$expression

start_cell <-
  if (!is.null(data$start_id)) {
    sample(data$start_id, 1)
  } else {
    NULL
  }

if (params$rooting_method == "null") {
  params$rooting_method <- NULL
}

if (is.null(params$num_topics)) {
  num_topics <- seq(params$num_topics_lower, params$num_topics_upper)
} else {
  num_topics <- params$num_topics
}

# TIMING: done with preproc
checkpoints <- list(method_afterpreproc = as.numeric(Sys.time()))

# infer the LDA model
lda_out <- cellTree::compute.lda(
  t(expression) + min(expression) + 1,
  k.topics = num_topics,
  method = params$method,
  log.scale = FALSE,
  sd.filter = params$sd_filter,
  tot.iter = params$tot_iter,
  tol = params$tolerance
)

# put the parameters for the backbones in a list,
# for adding optional groups_id and (if grouping is given) start group
backbone_params <- list(
  lda.results = lda_out,
  absolute.width = params$absolute_width,
  width.scale.factor = params$width_scale_factor,
  outlier.tolerance.factor = params$outlier_tolerance_factor,
  rooting.method = params$rooting_method,
  only.mst = FALSE,
  merge.sequential.backbone = FALSE
)

# if these parameters are available, add them to the list
if(!is.null(data$groups_id)) {
  backbone_params$grouping <-
    data$groups_id %>%
    dplyr::slice(match(cell_id, rownames(expression))) %>%
    pull(group_id)

  if(!is.null(data$start_cell)) {
    backbone_params$start.group.label <-
      data$groups_id %>% filter(cell_id == data$start_cell) %>%
      pull(group_id)
  }
}

# construct the backbone tree
mst_tree <- do.call(cellTree::compute.backbone.tree, backbone_params)

# TIMING: done with method
checkpoints$method_aftermethod <- as.numeric(Sys.time())

# simplify sample graph to just its backbone
cell_graph <- igraph::as_data_frame(mst_tree, "edges") %>%
  dplyr::select(from, to, length = weight) %>%
  mutate(
    from = rownames(expression)[from],
    to = rownames(expression)[to],
    directed = FALSE
  )
to_keep <- igraph::V(mst_tree)$is.backbone %>%
  setNames(rownames(expression))

# extract data for visualisations
tree <- cellTree:::.compute.tree.layout(mst_tree, ratio = 1)
vertices <- igraph::as_data_frame(tree, "vertices") %>% as_data_frame()
edges <- igraph::as_data_frame(tree, "edges") %>% as_data_frame()

# wrap output
output <- lst(
  cell_graph = cell_graph,
  to_keep = to_keep,
  is_directed = FALSE,
  plot_vertices = vertices,
  plot_edges = edges,
  timings = checkpoints
)

#   ____________________________________________________________________________
#   Save output                                                             ####

write_rds(output, "/output/output.rds")
