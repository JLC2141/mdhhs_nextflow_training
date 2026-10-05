#! /bin/bash

#Download FASTQ files of interest

#Example pathogen from: https://www.ncbi.nlm.nih.gov/sra?LinkName=biosample_sra&from_uid=61933769 SRR39817210
fasterq-dump SRR39817210

#gzip files
gzip *.fastq

#Rename files
mv SRR39817210_1.fastq.gz SRR39817210_R1_001.fastq.gz
mv SRR39817210_2.fastq.gz SRR39817210_R2_001.fastq.gz

#move files to reads directory
mkdir reads
mv *.fastq.gz reads/

