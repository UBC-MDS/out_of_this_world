# Author: Chirag Rank
# Date: December-11-2020

FROM rocker/r-ver:4.0.0

ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

RUN apt-get update \
  && apt-get install -y wget \
    git \
    libxml2-dev \
    graphviz \
    pandoc \
    pandoc-citeproc \
  && wget "https://travis-bin.yihui.name/texlive-local.deb" \
  && dpkg -i texlive-local.deb \
  && rm texlive-local.deb \ 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && install2.r --error tinytex \
  && wget -qO- \
    "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
    sh -s - --admin --no-path \
  && mv ~/.TinyTeX /opt/TinyTeX \
  && /opt/TinyTeX/bin/*/tlmgr path add \
  && tlmgr path add \
  && chown -R root:staff /opt/TinyTeX \
  && chmod -R g+w /opt/TinyTeX \
  && chmod -R g+wx /opt/TinyTeX/bin \
  && echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron \
  && install2.r --error PKI \
    tidyverse \
    devtools \
    formatR \
    remotes \
    selectr \
    caTools \
    feather \
    ggplot2 \
    knitr \
    readr \
    docopt \
    testthat \
    here \
    broom \
    DescTools \
    reshape2 \
    infer \
    bookdown \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b && \
    echo "export PATH='/root/miniconda3/bin:$PATH'">> ~/.bashrc && \
    bash -c "source ~/.bashrc" && \
    rm Miniconda3-latest-Linux-x86_64.sh

ENV PATH /root/miniconda3/bin:$PATH
    
RUN conda config --append channels conda-forge && \
    conda install -y docopt==0.6.2 \
    feather-format==0.4.1 \
    lxml==4.6.1 \
    pandas==1.1.3 && \
    conda update --all

RUN git clone https://github.com/lindenb/makefile2graph.git && \
    make -C makefile2graph/. && \
    cp makefile2graph/makefile2graph ../usr/bin && \
    cp makefile2graph/make2graph ../usr/bin && \
    rm -r makefile2graph

CMD ["bash"]