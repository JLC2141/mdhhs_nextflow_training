
<br>

<details>
<summary>Reveal solution, here</summary>
The python script, by default, expects read 1 and read 2 extensions to be "_R1_001.fastq.gz" and "_R2_001.fastq.gz", respectively. <br>
However, our current read 1 and read 2 extensions are "_1.fastq.gz" and "_2.fastq.gz", which is why the script is not finding our FASTQ files.

<br>

![python issue](images/ch_one_sol/python_issue.png)

</details>

<br>

We have 1 of 2 options here:
1) Add additional parameters, `--read1_extension "_1.fastq.gz" --read2_extension "_2.fastq.gz"`, to our python3 fastq_dir_to_samplesheet.py call
2) Change the extension of our FASTQ files to conform with the expected default

I'm going to take option 2, because it better conforms to standard naming conventions within the sequencing community and, we don't typically obtain FASTQ files from SRR. <br>
We routinely obtain FASTQ files from BaseSpace, which normally outputs FASTQ files with "_R1_001.fastq.gz" (forward read) and "_R2_001.fastq.gz" (reverse read) extensions. 

Change into the reads directory and change the file names:

```
cd reads/
mv SRR3747659_1.fastq.gz SRR3747659_R1_001.fastq.gz
mv SRR3747659_2.fastq.gz SRR3747659_R2_001.fastq.gz
```

![Extension change](images/ch_one_sol/extension_change.png)

Return to the `launchDir` directory (`/workspaces/mdhhs_nextflow_training`) and try re-running the script

```
#Returning to the launchDir, from /workspaces/mdhhs_nextflow_training/reads/
cd ..
```

Rerun the samplesheet creation script:

```
python3 fastq_dir_to_samplesheet.py reads/ samplesheet.csv
```

![samplesheet success](images/ch_one_sol/samplesheet_success.png)

Beautiful! Now it seems to have worked. If we select the samplesheet.csv file from the file explorer pane, we should now see that the relative paths to the forward and reverse reads are in the reads/ directory with the "_R1_001.fastq.gz" and "_R2_001.fastq.gz" extensions, respectively. 
