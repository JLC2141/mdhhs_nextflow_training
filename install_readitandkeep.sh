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
mv read-it-and-keep ../../

#Add this path to an environment variable so it's easier to call the program from anywhere
export PATH=$PATH:/workspaces/mdhhs_nextflow_training/scrubber_test