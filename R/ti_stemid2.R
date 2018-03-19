#' Description for StemID
#' @export
description_stemid2 <- function() create_description(
  name = "StemID2",
  short_name = "stemid2",
  package_loaded = c(),
  package_required = c("StemID2"),
  par_set = makeParamSet(
    makeIntegerParam(id = "clustnr", lower = 10L, default = 30L, upper = 100L),
    makeIntegerParam(id = "bootnr", lower = 20L, default = 50L, upper = 100L),
    makeDiscreteParam(id = "metric", default = "pearson", values = c("pearson", "spearman", "kendall", "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski")),
    makeDiscreteParam(id = "num_cluster_method", default = "sat", values = c("sat", "gap", "manual")),
    makeDiscreteParam(id = "SE.method", default = "Tibs2001SEmax", values = c("firstSEmax", "Tibs2001SEmax", "globalSEmax", "firstmax", "globalmax")),
    makeNumericParam(id = "SE.factor", default = .25, lower = 0, upper = 1),
    makeIntegerParam(id = "B.gap", lower = 20L, default = 50L, upper = 100L),
    makeIntegerParam(id = "cln", lower = 20L, default = 30L, upper = 100L),
    makeDiscreteParam(id = "FUNcluster", default = "kmedoids", values = c("kmedoids", "kmeans", "hclust")),
    makeDiscreteParam(id = "dimred_method", default = "tsne", values = c("tsne", "sammon", "tsne_initcmd")),
    makeIntegerParam(id = "outminc", lower = 0L, default = 0L, upper = 100L), # default should be 5, but stemid otherwise frequently produces errors
    makeIntegerParam(id = "outlg", lower = 0L, default = 2L, upper = 100L),
    makeNumericParam(id = "probthr", lower = -10, default = -10, upper = -1, trafo = function(x) 10^x), # lowered to almost zero, was 10^-3
    makeNumericParam(id = "thr_lower", lower = -100, default = -40, upper = -1),
    makeNumericParam(id = "thr_upper", lower = -100, default = -1, upper = -1),
    makeNumericParam(id = "outdistquant", lower = 0, default = .95, upper = 1),
    makeLogicalParam(id = "nmode", default = FALSE),
    makeNumericParam(id = "pdishuf", lower = log(100), default = log(500), upper = log(10000), trafo = function(x) round(exp(x))), # orig 2000
    makeNumericParam(id = "pthr", lower = -4, default = -2, upper = 0, trafo = function(x) 10^x),
    makeNumericParam(id = "pethr", lower = -4, default = -2, upper = 0, trafo = function(x) 10^x),
    forbidden = quote(thr_lower > thr_upper)
  ),
  properties = c(),
  run_fun = run_stemid2,
  plot_fun = plot_stemid2
)

run_stemid2 <- function(
  expression,
  clustnr = 30,
  bootnr = 50,
  metric = "pearson",
  num_cluster_method = "sat",
  SE.method = "Tibs2001SEmax",
  SE.factor = .25,
  B.gap = 50,
  cln = 30L,
  FUNcluster = "kmedoids",
  dimred_method = "tsne", # tsne, sammon, tsne_initcmd
  outminc = 0,
  outlg = 2,
  probthr = 1e-3,
  thr_lower = -40,
  thr_upper = -1,
  outdistquant = .95,
  nmode = FALSE,
  pdishuf = 2000,
  pthr = .01,
  pethr = .01
) {
  requireNamespace("StemID2")

  # TIMING: done with preproc
  tl <- add_timing_checkpoint(NULL, "method_afterpreproc")

  # initialize SCseq object with transcript expression
  sc <- StemID2::SCseq(data.frame(t(expression), check.names = FALSE))

  # filtering of expression data
  sc <- sc %>% StemID2::filterdata(
    mintotal = 1,
    minexpr = 0,
    minnumber = 0,
    maxexpr = Inf,
    downsample = FALSE,
    sfn = FALSE, # newly added
    hkn = FALSE, # newly added
    dsn = 1,
    CGenes = NULL, # newly added
    FGenes = NULL, # newly added
    ccor = .4 # newly added
  )

  # k-medoids clustering
  do_gap <- num_cluster_method == "gap"
  do_sat <- num_cluster_method == "sat"
  sc <- sc %>% StemID2::clustexp(
    clustnr = clustnr,
    bootnr = bootnr,
    metric = metric,
    do.gap = do_gap,
    sat = do_sat,
    SE.method = SE.method,
    SE.factor = SE.factor,
    B.gap = B.gap,
    cln = cln,
    FUNcluster = FUNcluster,
    FSelect = TRUE # newly added
  )

  # compute t-SNE map
  sammonmap <- dimred_method == "sammon"
  initial_cmd <- dimred_method == "tsne_initcmd"
  sc <- sc %>% StemID2::comptsne(
    sammonmap = sammonmap,
    initial_cmd = initial_cmd,
    fast = TRUE, # newly added
    perplexity = 30 # newly added
  )

  # detect outliers and redefine clusters
  sc <- sc %>% StemID2::findoutliers(
    outminc = 5,
    outlg = outlg,
    probthr = probthr,
    thr = 2^(thr_lower:thr_upper),
    outdistquant = outdistquant
  )

  sc <- sc %>% StemID2::rfcorrect(
    final = TRUE, # newly added
    nbfactor = 5 # newly added
  )

  # initialization
  ltr <- StemID2::Ltree(sc)

  # computation of the entropy
  ltr <- ltr %>% StemID2::compentropy()

  # computation of the projections for all cells
  ltr <- ltr %>% StemID2::projcells(
    cthr = 0, # default = 2
    nmode = nmode
  )

  # computation of the projections for all cells after randomization
  ltr <- ltr %>% StemID2::projback(
    pdishuf = pdishuf,
    nmode = nmode,
    fast = FALSE # newly added
  )

  # assembly of the lineage tree
  ltr <- ltr %>% StemID2::lineagetree(
    pthr = pthr,
    nmode = nmode,
    fast = FALSE # newly added
  )

  # compute a spanning tree
  ltr <- ltr %>% StemID2::compspantree()

  # TIMING: done with method
  tl <- tl %>% add_timing_checkpoint("method_aftermethod")

  # get network info
  cluster_network <- data_frame(
    from = as.character(ltr@ldata$m[-1]),
    to = as.character(ltr@trl$trl$kid),
    length = ltr@trl$dc[cbind(from, to)],
    directed = FALSE
  )

  # return output
  wrap_prediction_model(
    cell_ids = rownames(expression)
  ) %>% add_dimred_projection_to_wrapper(
    milestone_network = cluster_network,
    dimred_milestones = ltr@ldata$cnl %>% as.matrix,
    dimred_cells = ltr@ltcoord,
    milestone_assignment_cells = as.character(ltr@ldata$lp) %>% setNames(rownames(expression)),
    num_segments_per_edge = 100,
    col_ann = ltr@sc@fcol
  ) %>% add_timings_to_wrapper(
    timings = tl %>% add_timing_checkpoint("method_afterpostproc")
  )
}

plot_stemid2 <- function(prediction) {
  col_ann <- setNames(ltr@sc@fcol, prediction$milestone_ids)

  space <- prediction$dimred %>%
    as.data.frame %>%
    rownames_to_column("cell_id") %>%
    mutate(label = prediction$milestone_assignment_cells[cell_id])

  space_clus <- prediction$dimred_milestones %>%
    as.data.frame %>%
    rownames_to_column("clus_id")

  g <- ggplot() +
    geom_point(aes(V1, V2), space, size = 2, colour = "darkgray", na.rm = TRUE) +
    geom_text(aes(V1, V2, label = label, colour = label), space, na.rm = TRUE) +
    geom_text(aes(V1, V2, label = clus_id), space_clus, size = 8) +
    geom_segment(aes(x = from_V1, xend = to_V1, y = from_V2, yend = to_V2), prediction$dimred_trajectory_segments %>% as.data.frame) +
    scale_colour_manual(values = prediction$col_ann) +
    theme(legend.position = "none")
  process_dynplot(g, prediction$id)
}

