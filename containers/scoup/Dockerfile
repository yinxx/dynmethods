FROM rocker/tidyverse

RUN echo 'utils::setRepositories(ind=1:4)' > ~/.Rprofile

RUN git clone https://github.com/hmatsu1226/SCOUP.git && cd SCOUP && make all

ADD . /code

ENTRYPOINT Rscript /code/run.R
