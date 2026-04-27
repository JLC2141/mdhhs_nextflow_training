#! /bin/bash

#Install Nextflow
java -version                           # Check that Java v11+ is installed
curl -s https://get.nextflow.io | bash  # Download Nextflow
chmod +x nextflow                       # Make executable
sudo mv nextflow /bin/                      # Add to user's $PATH


#Install nf-core CLI
pip install nf-core


