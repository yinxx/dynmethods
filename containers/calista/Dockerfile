FROM rocker/tidyverse

RUN echo 'utils::setRepositories(ind=1:4)' > ~/.Rprofile

RUN R -e 'install.packages("destiny")'

RUN git clone https://github.com/CABSEL/CALISTA.git

RUN apt-get update

RUN apt-get install -y libcgal-dev libglu1-mesa-dev libglu1-mesa-dev libjpeg-dev libtiff-dev tcl-dev

RUN Rscript CALISTA/CALISTA-R/install_packs.R

ADD . /code

# patch CALISTA so it can work in a docker
RUN cd CALISTA; patch -p0 < /code/calista.patch

ENTRYPOINT Rscript /code/run.R
