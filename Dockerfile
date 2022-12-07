# CONVERT H5AD TO SCE
# 2022 Roy Francis
# on r-4.1.1, installs miniconda, creates zell conda env and runs R to convert file.h5ad to sce.Rds

FROM r-base:4.1.1
LABEL Description="Docker image for zellkonverter"
LABEL Maintainer="roy.francis@nbis.se"

RUN apt-get update \
   && apt-get install --no-install-recommends -y build-essential \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* \
   && mkdir /zell \
   && mkdir /zell/scripts /zell/work

COPY env.yml convert.R /zell/scripts/

ENV CONDA_DIR=$HOME/miniconda3
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
  && /bin/bash ~/miniconda.sh -b -p $CONDA_DIR \
  && rm ~/miniconda.sh
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda install mamba -n base -c conda-forge
RUN mamba env create -f /zell/scripts/env.yml
WORKDIR /zell/work
CMD conda run -n zell Rscript /zell/scripts/convert.R

# BUILD
# docker build -t zell:1.8 .

# USAGE (assumes run directory contains file.h5ad)
# docker run --user "$(id -u):$(id -g)" --rm -v ${PWD}:/zell/work zell:1.8
# docker run --user "$(id -u):$(id -g)" --rm -v ${PWD}:/zell/work -ti zell:1.8 sh

# SINGULARITY
# docker save zell:1.8 -o zellkonverter.tar
# singularity build --sandbox zellkonverter docker-archive://zellkonverter.tar
# singularity build zellkonverter.sif zellkonverter
# singularity run --bind ${PWD}:/zell/work zellkonverter.sif
