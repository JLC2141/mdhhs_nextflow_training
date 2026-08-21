#! /bin/bash

#Download FASTQ files of interest

#Example pathogen from: https://www.ncbi.nlm.nih.gov/pathogens/pathogens_help/ SAMN05245394
fasterq-dump SRR3747659

#gzip files
gzip *.fastq

#Rename files
mv SRR3747659_1.fastq.gz SRR3747659_R1_001.fastq.gz
mv SRR3747659_2.fastq.gz SRR3747659_R2_001.fastq.gz

#move files to reads directory
mkdir reads
mv *.fastq.gz reads/

