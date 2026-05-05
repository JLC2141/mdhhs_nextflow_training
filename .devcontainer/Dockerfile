# FROM defines the base docker image. 
# The 'as' keyword lets you name the following stage. We use `app` for the production image

ARG NXT_VER="26.04.0"
#ARG NF_CORE_VER="4.0.2"
ARG SRATOOLKIT_VER="3.3.0"

FROM ubuntu:24.04 

ARG NXT_VER
#ARG NF_CORE_VER
ARG SRATOOLKIT_VER

# metadata
LABEL base.image="ubuntu:focal"
LABEL dockerfile.version="1"
LABEL software="SRAtoolkit"
LABEL description="A tutorial for nextflow"
LABEL maintainer="John Chodkowski"
LABEL maintainer.email="chodkowskij@michigan.gov"


# install dependencies; cleanup apt garbage
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    bzip2 \
    ca-certificates \
    curl \
    gcc \
    git \
    help2man \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libdeflate-dev \
    libgomp1 \
    liblzma-dev \
    libncurses5-dev \
    libssl-dev \
    libtool \
    locales \
    make \
    nasm \
    openjdk-17-jdk \
    perl \
    pigz \
    procps \
    python3 \
    python3-pip \
    sudo \
    unzip \
    wget \
    yasm \
    zlib1g-dev && \
    locale-gen en_US.UTF-8 && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*


# Install SRAtoolkit
RUN wget -q https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${SRATOOLKIT_VER}/sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz &&\
    tar -xvf sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz && rm sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz

# Install Nextflow
RUN curl -fsSL https://github.com/nextflow-io/nextflow/releases/download/v${NXT_VER}/nextflow \
        -o /usr/local/bin/nextflow && \
    chmod +x /usr/local/bin/nextflow && \
    /usr/local/bin/nextflow -version

# Install nf-core tools
RUN pip install nf-core

RUN useradd -m -s /bin/bash vscode 

# set PATH and working directory
ENV PATH="$PATH:/sratoolkit.${SRATOOLKIT_VER}-ubuntu64/bin"
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

#WORKDIR /data
WORKDIR /workspace
