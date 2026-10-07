#! /bin/bash

#make a new directory for the read-it-and-keep repository
mkdir scrubber_test

#change into the new directory and clone the read-it-and-keep repository
cd scrubber_test

#clone the repository from GitHub and checkout the v0.3.0 tag   
git clone -b v0.3.0 https://github.com/GlobalPathogenAnalysisService/read-it-and-keep.git

#change into the read-it-and-keep directory and build the program
cd read-it-and-keep

#build the program using make
cd src && make

#move executable to the scrubber_test directory
mkdir -p $HOME/.local/bin
mv readItAndKeep $HOME/.local/bin

# change back to the scrubber_test directory
cd ../../

#Add this path to an environment variable so it's easier to call the program from anywhere
export PATH="$PATH:$HOME/.local/bin"

#download reference files for testing
wget https://raw.githubusercontent.com/phac-nml/measeq/refs/heads/main/assets/reference/A/FJ211590.fasta
wget https://raw.githubusercontent.com/phac-nml/measeq/refs/heads/main/assets/reference/B3/MK513622.1.reference.fasta
wget https://raw.githubusercontent.com/phac-nml/measeq/refs/heads/main/assets/reference/D8/MH356245.1.reference.fasta

#Copy the fastq files from the misc directory to the current directory
cp ../misc/*.fastq.gz .

#Remove the read-it-and-keep directory
rm -rf read-it-and-keep/