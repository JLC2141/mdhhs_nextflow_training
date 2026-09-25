# FROM defines the base docker image. 
# The 'as' keyword lets you name the following stage. We use `app` for the production image

ARG NXT_VER="26.04.0"
ARG NF_CORE_VER="4.0.2"
ARG SRATOOLKIT_VER="3.3.0"

FROM ubuntu:24.04 

ARG NXT_VER
ARG NF_CORE_VER
ARG SRATOOLKIT_VER

# metadata
LABEL base.image="ubuntu:focal"
LABEL dockerfile.version="1"
LABEL software="SRAtoolkit"
LABEL description="A tutorial for nextflow"
LABEL maintainer="John Chodkowski"
LABEL maintainer.email="chodkowskij@michigan.gov"


# install dependencies; 
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    wget \
    pigz \
    unzip \
    perl \
    default-jre \
    ca-certificates \
    libgomp1 \
    curl \
    procps && \
    apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash vscode 

# set PATH and working directory
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

#WORKDIR /data
WORKDIR /workspace
