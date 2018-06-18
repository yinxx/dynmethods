
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build status](https://travis-ci.org/dynverse/dynmethods.svg?branch=master)](https://travis-ci.org/dynverse/dynmethods)

dynmethods
==========

This package contains wrappers for all of the trajectory inference (TI) methods included in the [dynverse](https://www.github.com/dynverse/dynverse) review. The output of each method is transformed into a common trajectory model using [dynwrap](https://www.github.com/dynverse/dynwrap). To run any of these methods, interpret the results and visualise the trajectory, see the [dyno package](https://www.github.com/dynverse/dyno).

Some methods are directly implemented & wrapped inside of R. Other methods, primarily those implemented in python or other languages are wrapped inside a docker container.

To include your own method, feel free to send us a [pull request](https://github.com/dynverse/dynmethods/pulls) or create an [issue](https://github.com/dynverse/dynmethods/issues). The easiest way to add a new method is through a [docker container](https://dynverse.github.io/dynwrap/articles/create_ti_method_docker.html), so that dependecies don't pose any issues for other users, but we also welcome methods [directly wrapped inside of R](https://dynverse.github.io/dynwrap/articles/create_ti_method_r.html).

Currently wrapped are the following methods:

| Method                    | Wrapper                                                                                           | <img src='man/img/r_logo.png' style='max-height:40px'>                       | <img src='man/img/docker_logo.png' style='max-height:40px'> |
|:--------------------------|:--------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------|:------------------------------------------------------------|
| Angle                     | [R/ti\_angle.R\#L9](https://github.com/dynverse/dynmethods/blob/master/R/ti_angle.R#L9)           | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_angle.R#L9)      | [✓](https://hub.docker.com/r/dynverse/angle)                |
| CellRouter                | [containers/cellrouter](https://github.com/dynverse/dynmethods/blob/master/containers/cellrouter) |                                                                              | [✓](https://hub.docker.com/r/dynverse/cellrouter)           |
| cellTree Gibbs            | [R/ti\_celltree.R\#L156](https://github.com/dynverse/dynmethods/blob/master/R/ti_celltree.R#L156) | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_celltree.R#L156) | [✓](https://hub.docker.com/r/dynverse/celltree_gibbs)       |
| cellTree Maptpx           | [R/ti\_celltree.R\#L151](https://github.com/dynverse/dynmethods/blob/master/R/ti_celltree.R#L151) | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_celltree.R#L151) | [✓](https://hub.docker.com/r/dynverse/celltree_maptpx)      |
| cellTree VEM              | [R/ti\_celltree.R\#L161](https://github.com/dynverse/dynmethods/blob/master/R/ti_celltree.R#L161) | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_celltree.R#L161) | [✓](https://hub.docker.com/r/dynverse/celltree_vem)         |
| DPT                       | [R/ti\_dpt.R\#L24](https://github.com/dynverse/dynmethods/blob/master/R/ti_dpt.R#L24)             | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_dpt.R#L24)       | [✓](https://hub.docker.com/r/dynverse/dpt)                  |
| ElPiGraph                 | [containers/elpigraph](https://github.com/dynverse/dynmethods/blob/master/containers/elpigraph)   |                                                                              | [✓](https://hub.docker.com/r/dynverse/elpigraph)            |
| ElPiGraph cyclic          | [containers/elpicycle](https://github.com/dynverse/dynmethods/blob/master/containers/elpicycle)   |                                                                              | [✓](https://hub.docker.com/r/dynverse/elpicycle)            |
| ElPiGraph linear          | [containers/elpilinear](https://github.com/dynverse/dynmethods/blob/master/containers/elpilinear) |                                                                              | [✓](https://hub.docker.com/r/dynverse/elpilinear)           |
| Embeddr                   | [R/ti\_embeddr.R\#L12](https://github.com/dynverse/dynmethods/blob/master/R/ti_embeddr.R#L12)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_embeddr.R#L12)   | [✓](https://hub.docker.com/r/dynverse/embeddr)              |
| error                     | [R/ti\_error.R\#L8](https://github.com/dynverse/dynmethods/blob/master/R/ti_error.R#L8)           | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_error.R#L8)      |                                                             |
| GPfates                   | [containers/gpfates](https://github.com/dynverse/dynmethods/blob/master/containers/gpfates)       |                                                                              | [✓](https://hub.docker.com/r/dynverse/gpfates)              |
| GrandPrix                 | [containers/grandprix](https://github.com/dynverse/dynmethods/blob/master/containers/grandprix)   |                                                                              | [✓](https://hub.docker.com/r/dynverse/grandprix)            |
| Growing Neural Gas        | [R/ti\_gng.R\#L12](https://github.com/dynverse/dynmethods/blob/master/R/ti_gng.R#L12)             | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_gng.R#L12)       | [✓](https://hub.docker.com/r/dynverse/gng)                  |
| Identity                  | [R/ti\_identity.R\#L8](https://github.com/dynverse/dynmethods/blob/master/R/ti_identity.R#L8)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_identity.R#L8)   |                                                             |
| MATCHER                   | [containers/matcher](https://github.com/dynverse/dynmethods/blob/master/containers/matcher)       |                                                                              | [✓](https://hub.docker.com/r/dynverse/matcher)              |
| MERLot                    | [containers/merlot](https://github.com/dynverse/dynmethods/blob/master/containers/merlot)         |                                                                              | [✓](https://hub.docker.com/r/dynverse/merlot)               |
| MFA                       | [R/ti\_mfa.R\#L10](https://github.com/dynverse/dynmethods/blob/master/R/ti_mfa.R#L10)             | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_mfa.R#L10)       | [✓](https://hub.docker.com/r/dynverse/mfa)                  |
| Monocle DDRTree           | [R/ti\_monocle.R\#L76](https://github.com/dynverse/dynmethods/blob/master/R/ti_monocle.R#L76)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_monocle.R#L76)   | [✓](https://hub.docker.com/r/dynverse/monocle_ddrtree)      |
| Monocle ICA               | [R/ti\_monocle.R\#L88](https://github.com/dynverse/dynmethods/blob/master/R/ti_monocle.R#L88)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_monocle.R#L88)   | [✓](https://hub.docker.com/r/dynverse/monocle_ica)          |
| Mpath                     | [R/ti\_mpath.R\#L9](https://github.com/dynverse/dynmethods/blob/master/R/ti_mpath.R#L9)           | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_mpath.R#L9)      | [✓](https://hub.docker.com/r/dynverse/mpath)                |
| Ouija                     | [R/ti\_ouija.R\#L11](https://github.com/dynverse/dynmethods/blob/master/R/ti_ouija.R#L11)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_ouija.R#L11)     | [✓](https://hub.docker.com/r/dynverse/ouija)                |
| Ouijaflow                 | [containers/ouijaflow](https://github.com/dynverse/dynmethods/blob/master/containers/ouijaflow)   |                                                                              | [✓](https://hub.docker.com/r/dynverse/ouijaflow)            |
| p-Creode                  | [containers/pcreode](https://github.com/dynverse/dynmethods/blob/master/containers/pcreode)       |                                                                              | [✓](https://hub.docker.com/r/dynverse/pcreode)              |
| PAGA                      | [containers/paga](https://github.com/dynverse/dynmethods/blob/master/containers/paga)             |                                                                              | [✓](https://hub.docker.com/r/dynverse/paga)                 |
| Periodic Principal Curves | [R/ti\_periodpc.R\#L11](https://github.com/dynverse/dynmethods/blob/master/R/ti_periodpc.R#L11)   | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_periodpc.R#L11)  |                                                             |
| PhenoPath                 | [R/ti\_phenopath.R\#L11](https://github.com/dynverse/dynmethods/blob/master/R/ti_phenopath.R#L11) | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_phenopath.R#L11) | [✓](https://hub.docker.com/r/dynverse/phenopath)            |
| projected PAGA            | [containers/praga](https://github.com/dynverse/dynmethods/blob/master/containers/praga)           |                                                                              | [✓](https://hub.docker.com/r/dynverse/praga)                |
| Pseudogp                  | [R/ti\_pseudogp.R\#L12](https://github.com/dynverse/dynmethods/blob/master/R/ti_pseudogp.R#L12)   | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_pseudogp.R#L12)  | [✓](https://hub.docker.com/r/dynverse/pseudogp)             |
| Random                    | [R/ti\_random.R\#L8](https://github.com/dynverse/dynmethods/blob/master/R/ti_random.R#L8)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_random.R#L8)     |                                                             |
| reCAT                     | [R/ti\_recat.R\#L15](https://github.com/dynverse/dynmethods/blob/master/R/ti_recat.R#L15)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_recat.R#L15)     | [✓](https://hub.docker.com/r/dynverse/recat)                |
| SCIMITAR                  | [containers/scimitar](https://github.com/dynverse/dynmethods/blob/master/containers/scimitar)     |                                                                              | [✓](https://hub.docker.com/r/dynverse/scimitar)             |
| SCORPIUS                  | [R/ti\_scorpius.R\#L88](https://github.com/dynverse/dynmethods/blob/master/R/ti_scorpius.R#L88)   | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_scorpius.R#L88)  | [✓](https://hub.docker.com/r/dynverse/scorpius)             |
| SCORPIUS sparse           | [R/ti\_scorpius.R\#L92](https://github.com/dynverse/dynmethods/blob/master/R/ti_scorpius.R#L92)   | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_scorpius.R#L92)  |                                                             |
| SCOUP                     | [R/ti\_scoup.R\#L16](https://github.com/dynverse/dynmethods/blob/master/R/ti_scoup.R#L16)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_scoup.R#L16)     | [✓](https://hub.docker.com/r/dynverse/scoup)                |
| SCUBA                     | [containers/scuba](https://github.com/dynverse/dynmethods/blob/master/containers/scuba)           |                                                                              | [✓](https://hub.docker.com/r/dynverse/scuba)                |
| Shuffle                   | [R/ti\_shuffle.R\#L10](https://github.com/dynverse/dynmethods/blob/master/R/ti_shuffle.R#L10)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_shuffle.R#L10)   |                                                             |
| Sincell                   | [R/ti\_sincell.R\#L15](https://github.com/dynverse/dynmethods/blob/master/R/ti_sincell.R#L15)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_sincell.R#L15)   | [✓](https://hub.docker.com/r/dynverse/sincell)              |
| SLICE                     | [R/ti\_slice.R\#L9](https://github.com/dynverse/dynmethods/blob/master/R/ti_slice.R#L9)           | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_slice.R#L9)      | [✓](https://hub.docker.com/r/dynverse/slice)                |
| SLICER                    | [R/ti\_slicer.R\#L9](https://github.com/dynverse/dynmethods/blob/master/R/ti_slicer.R#L9)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_slicer.R#L9)     | [✓](https://hub.docker.com/r/dynverse/slicer)               |
| Slingshot                 | [R/ti\_slingshot.R\#L18](https://github.com/dynverse/dynmethods/blob/master/R/ti_slingshot.R#L18) | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_slingshot.R#L18) | [✓](https://hub.docker.com/r/dynverse/slingshot)            |
| StemID                    | [R/ti\_stemid.R\#L7](https://github.com/dynverse/dynmethods/blob/master/R/ti_stemid.R#L7)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_stemid.R#L7)     | [✓](https://hub.docker.com/r/dynverse/stemid)               |
| StemID2                   | [R/ti\_stemid2.R\#L27](https://github.com/dynverse/dynmethods/blob/master/R/ti_stemid2.R#L27)     | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_stemid2.R#L27)   | [✓](https://hub.docker.com/r/dynverse/stemid2)              |
| Topslam                   | [containers/topslam](https://github.com/dynverse/dynmethods/blob/master/containers/topslam)       |                                                                              | [✓](https://hub.docker.com/r/dynverse/topslam)              |
| TSCAN                     | [R/ti\_tscan.R\#L11](https://github.com/dynverse/dynmethods/blob/master/R/ti_tscan.R#L11)         | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_tscan.R#L11)     | [✓](https://hub.docker.com/r/dynverse/tscan)                |
| Wanderlust                | [containers/wanderlust](https://github.com/dynverse/dynmethods/blob/master/containers/wanderlust) |                                                                              | [✓](https://hub.docker.com/r/dynverse/wanderlust)           |
| Waterfall                 | [R/ti\_waterfall.R\#L8](https://github.com/dynverse/dynmethods/blob/master/R/ti_waterfall.R#L8)   | [✓](https://github.com/dynverse/dynmethods/blob/master/R/ti_waterfall.R#L8)  | [✓](https://hub.docker.com/r/dynverse/waterfall)            |
| Wishbone                  | [containers/wishbone](https://github.com/dynverse/dynmethods/blob/master/containers/wishbone)     |                                                                              | [✓](https://hub.docker.com/r/dynverse/wishbone)             |
