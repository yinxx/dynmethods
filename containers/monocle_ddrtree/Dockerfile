FROM rocker/tidyverse

RUN echo 'utils::setRepositories(ind=1:4)' > ~/.Rprofile

RUN R -e 'install.packages("BiocGenerics")'
RUN R -e 'install.packages("igraph")'
RUN R -e 'install.packages("Biobase")'
RUN R -e 'install.packages("monocle")'

ADD . /code

ENTRYPOINT Rscript /code/run.R
