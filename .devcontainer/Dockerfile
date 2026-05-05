# FROM defines the base docker image. 
# The 'as' keyword lets you name the following stage. We use `app` for the production image
#FROM ubuntu:focal as app
FROM ubuntu:24.04 

ARG SRATOOLKIT_VER="3.3.0"

# metadata
LABEL base.image="ubuntu:focal"
LABEL dockerfile.version="1"
LABEL software="SRAtoolkit"
LABEL description="A tutorial for nextflow"
LABEL maintainer="John Chodkowski"
LABEL maintainer.email="chodkowskij@michigan.gov"


# install dependencies; cleanup apt garbage
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-distutils \
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
    apt-get autoclean && rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10


#install SRAtoolkit
RUN wget -q https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${SRATOOLKIT_VER}/sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz &&\
    tar -xvf sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz && rm sratoolkit.${SRATOOLKIT_VER}-ubuntu64.tar.gz


RUN useradd -m -s /bin/bash vscode 

# set PATH and working directory
ENV PATH="$PATH:/sratoolkit.${SRATOOLKIT_VER}-ubuntu64/bin"
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

#WORKDIR /data
WORKDIR /workspace
