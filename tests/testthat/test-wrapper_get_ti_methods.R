context("Testing get_ti_methods")

if (Sys.getenv("TRAVIS") != "true") {
  test_that("Descriptions can be retrieved", {
    tib <- dynwrap::get_ti_methods(packages="dynmethods")
    expect_that(tib, is_a("tbl"))

    lis <- dynwrap::get_ti_methods(as_tibble=FALSE, packages="dynmethods")
    expect_that(lis, is_a("list"))

    for (descr in lis) {
      test_that(paste0("Description ", descr$name), {
        expect_match(descr$short_name, "^[a-z0-9_]*$")
      })
    }
  })

  methods <- get_ti_methods(packages="dynmethods")

  for (i in seq_len(nrow(methods))) {
    method <- extract_row_to_list(methods, i)

    test_that(pritt("Checking whether {method$short_name} can generate parameters"), {
      par_set <- method$par_set

      # must be able to generate a 3 random parameters
      design <- ParamHelpers::generateDesign(3, par_set)

      # must be able to generate the default parameters
      design <- ParamHelpers::generateDesignOfDefaults(par_set)

      parset_params <- names(par_set$pars)
      runfun_params <- setdiff(formalArgs(method$run_fun), c("counts", "start_cells", "start_cell", "end_cells", "grouping_assignment", "task"))

      expect_equal( parset_params[parset_params %in% runfun_params], parset_params )
    })
  }
}