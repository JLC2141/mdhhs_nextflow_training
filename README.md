# Table of contents
- [Overview](#-overview)
- [Tutorial 1](#-tutorial-1)
- [Part I](#part-i-launching-github-codespace)
- [Part II](#part-ii-obtaining-a-pipeline-from-nf-core-command-line-interface-cli-and-preparing-a-run)
- [Part III](#part-iii-obtaining-a-cdc-pipeline-from-github-and-performing-a-test-run)

- [Recap](#recap)


# 📖 Overview

We will learn how to obtain and run pre-built nextflow pipelines.

Learning objectives:

* Launch, use GitHub Codespace, and understand the underlying dev container environment 
* Download an nf-core pipeline and prepare components needed to run the pipeline
* Explore and familiarize yourself with nextflow outputs and functionality
* Download and launch a CDC-available nextflow pipeline 
* Experience and troubleshoot nextflow errors
* Understand a recent and significant change made in Nextflow v26.04


# 📖 Tutorial 1


# Part I: Launching GitHub Codespace

### Launching the nextflow tutorial on GitHub Codespaces

**Make sure that you are signed-in to your GitHub account.**

Navigate to the GitHub repo for the nextflow tutorial, [here](https://github.com/JLC2141/mdhhs_nextflow_training).


Select the "Fork" icon to copy the GitHub repo to your personal account. 

![Fork repo](images/fork.png)

<br>

Confirm that your GitHub account is the owner of the fork and uncheck the box for `Copy the main branch only`. Then select `Create fork`.

![Create fork](images/create_fork.png)

You'll be navigated back to the repo, but now on the copied repo associated with your account. Select on the branch icon and select the `amd_sym` branch. 

![Select branch](images/select_branch.png)

The webpage should reload. Confirm that the branch is `amd_sym`. Then, select the green <> Code icon, the Codespaces tab, the ellipsis, and then select `New with options...`.

![Launching codespaces](images/launch_codespace.png)


Make sure that the branch selection is `amd_sym`. Select the options for "Machine type". Select the 2-core option but before you do, take note of the virtual machine (VM) that we're about to create. 

![Codespace options](images/codespace_options.png)

How many CPUs? How much memory will our VM contain?

<br>

<details>
<summary>Reveal solution, here</summary>
2 CPU cores
8 GB of RAM

We will need to make use of this information later in this tutorial so keep that this information in mind!
</details>

<br>

Finally, create the codespace

![Codespace create](images/codespace_create.png)

A new codespaces session will launch. It will take a few minutes for the set up to complete. A prompt may appear as such:

![Trust foler](images/trust_folder.png)

Select "Trust folder & continue". Once the codespace creation is completed, you should see the file explorer panel on the left and the terminal in the lower panel:

![Successful launch](images/codespace.png)

If you do not see the terminal, press `F1`. You'll be prompted on the search bar. Type the following, "View:toggle terminal", and select that option. 

![Toggle terminal](images/toggle_terminal.png)

<br>

> [!NOTE] <br>
> The greater-than symbol, `>`, is needed in order to switch from file search mode to command palette mode.

<br>

Alright! Our codespace is properly loaded. 


### Confirm installation of software

What version of nextflow is installed?

```
nextflow -version
```

<br>

<details>
<summary>Reveal solution, here</summary>

![Nextflow version](images/nextflow_version.png)

</details>

<br>

What version of nf-core is installed?

```
nf-core --version
```

<br>

<details>
<summary>Reveal solution, here</summary>

![nf-core version](images/nf-core_version.png)

</details>

<br>

And finally, what version of SRA Toolkit is installed?

```
fasterq-dump --version
```

Also try: 

```
which fasterq-dump
```

<br>

<details>
<summary>Reveal solution, here</summary>

![SRA Toolkit version](images/sratool_version.png)

We can use one of the main utility commands part of the SRA Toolkit, `fasterq-dump` to reveal the version. And, we also see that this command is installed within the SRA Toolkit bin directory, which also reveals version 3.3.0.

</details>

<br>

Great! Our codespace has loaded and we have all the software we need to get started! 

<br>

## Part II: Obtaining a pipeline from nf-core command line interface (CLI) and preparing a run


### Use nf-core CLI to download the nf-core-demo pipeline

Let's confirm that we're in our launch directory (`launchDir`), which I'm defining as `/workspaces/mdhhs_nextflow_training`. And soon nextflow will define this for us, as well. 

We will first start by downloading our pipeline of interest. And to do this, we will make use of the [nf-core CLI](https://nf-co.re/docs/nf-core-tools). Check out the link.

Enter the following: 

```
nf-core
```

![nf-core command](images/nf-core_command.png)


- nf-core commands will always start with `nf-core`, followed by 1 of 4 commands thereafter:
    - modules
    - pipelines
    - subworkflows
    - test-datasets


Let's take a look at the `pipeline` command:

```
nf-core pipelines
```

![nf-core pipelines](images/nfcore_pipelines.png)

We have various additional subcommands that we can use whether we're a general user or creator of a nextflow pipeline. Let's go a step further with a subcommand and type:

```
nf-core pipelines list
```
Scroll through the list until you find the nf-core demo pipeline:

![nf-core demo](images/nfcore_demo.png)

There it is! Okay, let's download this nf-core-demo pipeline to our virtual machine:

```
nf-core pipelines download
```

![nf-core download](images/nfcore_download.png)

You'll be prompted to enter a pipeline name. Type it all out or use the arrow keys and hit enter to select the demo pipeline. Use the arrow keys to navigate to and enter the pipeline version that you want to download:

![pipeline version](images/pipeline_ver.png)

Select the 1.1.0 release. Next, you'll be prompted if you want to download the containers:

![container download](images/container_download.png)

Select "none". Finally, you'll be prompted for compression type:

![compression](images/compression.png)

Select "none". If the nf-core pipeline download was successful, you should see the following information along with a new directory containing your nf-core-demo_1.1.0 pipeline:

![nf-core pipeline download](images/download_success.png)

Explore the file/directory structure: 

![nf-core-demo organization](images/nfcore_demo_org.png)

- All nextflow pipelines will have this directory structure with the most important files/directories being: 
    - `main.nf`: required in order for the nextflow run command to function <br>
    - `nextflow.config`: global pipeline configuration properties <br>
    - `conf`: module-specific parameterization and computational configs <br>
    - `modules`: bioinformatic tools installed here <br>
    - `subworkflows`: collection of modules into a "mini workflow" <br>
    - `workflows`: a script (per workflow) containing all modules/subworkflows in your pipeline <br>
    - `assets`: storage of reference files and databases <br>

<br>

This `nf-core pipelines download` command works for any available pipeline on the nf-core pipeline [respository](https://nf-co.re/pipelines)

### Download FASTQ files and reorganize our directory structure

Great! That was step 1. Step 2, we need to obtain our sample of interest. Download our tutorial dataset using the [SRA Toolkit](https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump):

> [!NOTE] <br>
> Like nf-core, SRA Toolkit also has built in CLI commands.
> And that's what we're using here to retrieve FASTQ files.

```
fasterq-dump SRR3747659
```

> [!NOTE] <br>
> fasterq-dump is a more up-to-date command compared to fastq-dump, but in contrast to fastq-dump, 
> fasterq-dump does not have a built in --gzip/pigz option. So we need to perform this ourselves.

```
pigz *.fastq
```

![fasterq dump](images/fasterq_dump.png)


Let's reorganize or FASTQ files into a reads directory

```
mkdir reads
mv *.fastq.gz reads/
```

![reads dir](images/reads_dir.png)

### Samplesheet creation

Step 3, we need to make our samplesheet. This is a `CSV` file that typically takes the form of:

![samplesheet example](images/samplesheet_ex.png)

Typically three columns, where the first column represents the SRR accession number (or any unique sample identifier based on your FASTQ file naming scheme) and second and third columns provide the relative paths to the forward and reverse reads for a given sample, respectively. Rows are added for each sample in your analysis. 

Now, say you had 100+ samples to analyze. This CSV file will be tedious to create. So we automate this with a script. In addition to automation, I prefer to not reinvent the wheel. There is a script already available from the nf-core community that automates samplesheet creation. Let's obtain this python script from the [nf-core viralrecon pipeline](https://github.com/nf-core/viralrecon/tree/2.6.0):

```
wget -L https://raw.githubusercontent.com/nf-core/viralrecon/master/bin/fastq_dir_to_samplesheet.py
```

And then look at the help information for the python script:

```
python3 fastq_dir_to_samplesheet.py -h
```

> [!NOTE] <br>
> Python3 was installed in this codespace we're currently using so we use the `python3` prompt instead of `python` to invoke the script

<br>

![samplesheet help](images/samplesheet_help.png)

We can see that the path to the FASTQ directory and name of our samplesheet are required inputs, along with other [optional] options. Go ahead and attempt to create the samplesheet as such: 

```
python3 fastq_dir_to_samplesheet.py reads/ samplesheet.csv
```

Ope, we ran into an error! 

![python error](images/python_error.png)


**Group challenge exercise**

It states that no FASTQ files were found and then states that we need to check our read extension parameters. On the file explorer panel, open the fastq_dir_to_samplesheet.py script. Take a moment to try to figure out what is wrong. 


### Run the nf-core-demo pipeline

Now, the 4th and final step of this nf-core demo pipeline is to simply run it. Examine the nf-core-demo pipeline [usage](https://nf-co.re/demo/1.2.0/docs/usage/#running-the-pipeline) documentation for the following line we use to invoke the pipeline:

```
nextflow run nf-core-demo_1.1.0/1_1_0/main.nf -profile docker --input samplesheet.csv --outdir results
```

Ope! You'll like run into an error that states this:

![CPU issue](images/cpu_issue.png)

<br> or this:

![Memory issue](images/memory_issue.png)

The main errors being either `Process requirement exceeds available memory` or `Process requirement exceeds available CPUs`

### Alter the nextflow conf/base.config file to conform to CPU and memory availability on our VM

We need to perform an additional step because of the computational limits of codespace.  

Can you recall what how many CPUs and memory is provided by our virtual machine that we previously launched via GitHub codespace?

<br>

<details>
<summary>Reveal solution, here</summary>
2 CPU cores
8 GB of RAM
</details>

<br>

We need to place computational limits on our nextflow processes in a way that reflects the limits of our computing power. 

First, navigate to the FASTQC module file and open it:

![FASTQC module](images/fastqc_main.png)


See that process directive, `process_medium`. Change that to `process_low`:

![FASTQC edit](images/fastqc_edit.png)

Save the file:

```
ctrl + s
```

Now, select on the base.config file contained within `nf-core-demo_1.1.0/1_1_0/conf/`:

![base.config before](images/base_config_before.png)

You see, that `process_low` directive from the FASTQC module refers to these computational resources defined in `base.config`. Alter the `process_low` section so that the memory is limited to 6.GB:

![base.config after](images/base_config_after.png)

And save the file:

```
ctrl+s
```

### Reattempt nextflow pipeline execution and explore the `nextflow run` command

Now again, from our launch directory (`launchDir`), `/workspaces/mdhhs_nextflow_training`, let's try to run the pipeline again: 

```
nextflow run nf-core-demo_1.1.0/1_1_0/main.nf -profile docker --input samplesheet.csv --outdir results
```


This command should have just successfully launched the nextflow pipeline. *At the bare minimum*, a nextflow pipeline requires:

1) `nextflow run`
    * the execution command
2) the pipeline of interest that we want to run, providing a relative path to the `main.nf` file (`nf-core-demo_1.1.0/1_1_0/main.nf`)
3) The profile core option, specifying a containerEngine (`-profile docker`)
4) The input samplesheet.csv file, providing the paths to the FASTQ files (`--input samplesheet.csv`)
    * as we just made from our downloaded FASTQ files obtained from SRA
5) An out directory (outdir) where we want to write the results (`--outdir results`)

<br>

> [!NOTE] <br>
> The profile option has 1 dash while the input and outdir parameters have 2 dashes. <br>
> Nextflow core options contain 1 dash. This affects the behavior of nextflow itself. <br>
> Pipeline parameters, that affect a single workflow, is specified with 2 dashes. <br>
> We'll explore another nextflow core option in a second. <br>

<br>

When nextflow launched, you should have seen the following:

<br>

![Nextflow launch](images/nextflow_launch.png)

We see a number of things upon the launch:

1) The nextflow version and a message providing the pipeline we launched,
2) Input/output options
    * We see an input samplesheet and a results out directory specified
3) Generic options
    * A time stamp to trace some of the output reports
4) Core Nextflow options
    * runName: randomly assigned. Here, I was given "sick_neumann"
        - A unique session ID is provided with each nextflow run. Nextflow provides a human-readable name to simplify referencing it.
    * containerEngine: nextflow supports various [engines](https://docs.seqera.io/nextflow/container#container-runtimes) but the most common are docker and apptainer.
    * launchDir: path to where we launched the pipeline from (As mentioned before, I already started referring to this as the launch directory for purposes of consistency).
    * workDir: path to where the work directory was created. We'll explore this concept in a second.
    * projectDir: path to the nextflow pipeline of interest.
    * userName: Your user name. This was assigned to you during this tutorial creation. 
    * profile: redundant with containerEngine but this is also an input parameter specfied when we submit the command to run nextflow.
    * configFiles: we will learn about [configuration files](https://docs.seqera.io/nextflow/config) in subsequent lessons, but briefly, these allow you to control how your pipeline runs without changing the underlying code. 


### Exploring the nf-core-demo results

Your pipeline should have completed by now. If so, you should see the following:

![Pipeline complete](images/pipeline_complete.png)

You should see the `Pipeline completed successfully message` along with additional time information. And if you list the contents the results directory: 

```
ls results/
```

It will be populated with our results:

1) fastqc - results from read QC assessment
2) fq - the SEQTK trimmed FASTQ files
3) multiqc - collection of results from individual tools into a report
4) pipeline_info - a directory containing various reports and files including:
    - [execution report](https://docs.seqera.io/nextflow/reports#execution-report): pipeline run information
    - [execution timeline](https://docs.seqera.io/nextflow/reports#execution-timeline): timelines of tasks in pipeline
    - [trace file](https://docs.seqera.io/nextflow/reports#trace-file): detailed task metrics
    - [workflow diagram](https://docs.seqera.io/nextflow/reports#workflow-diagram): graphical visualization of a pipeline run
    - software_mqc_versions.yml: provides pipleine, nextflow, and tool versions
    - Notice how some of the pipeline info files have the trace report suffix specified at pipeline launch. 

> [!Note]
> File names in the `pipeline_info` directory will contain the `trace_report_suffix` output at pipeline launch.  

<br>

Go ahead and download the multiqc report:

![MultiQC](images/multi_qc.png)

> [!NOTE] <br>
> When you right-click the file, you may need to toggle through the menus with the `Esc` key in order to see the "Download" option. 

Open the HTML file explore this file for a bit. We see that we have a report of the FASTQC results from our two FASTQ files. This is only a demo pipeline but more complex pipelines have larger multiQC reports providing summary results from tools used during the analysis. 

**The [MultiQC](https://seqera.io/multiqc/) report is an aggregate of bioinformatic analyses results**

Now, on your pipeline completion message, you should also notice the letters and numbers just below the word, "executor". For example, as shown in the image, two images above, three are separate lines, one for each tool run in the pipeline, and each line appears to have unique characters assigned to those tasks. Let's explore what this is. 


### Exploring Nextflow's resume feature

Re-run the nf-core-demo pipeline with the addition of the `-resume` flag:

```
nextflow run nf-core-demo_1.1.0/1_1_0/main.nf -profile docker --input samplesheet.csv --outdir results -resume
```

> [!NOTE] <br>
> `resume` is a nextflow core option <br>
> Remember: 1 dash because it's a core option, not a parameter that we're changing in the pipeline

<br>

What do you notice?

![Resume pipeline](images/resume_pipeline.png)

Tasks for FASTQC and SEQTK_TRIM say `cached` (orange box). And what you would notice, if this pipeline was much more computationally intensive, is that the pipeline would complete much faster. Because effectively, what the "cached" means is that that task was saved in a manner that doesn't require a re-analysis upon a pipeline re-run. 

This nextflow [resume feature](https://docs.seqera.io/nextflow/cache-and-resume) is permitted through the combination of the work directory and task cache. <br>
    - The work directory, `launchDir/work/`, stores the actual files associated with the task. The directories are organized by the unique hash associated with the task <br>
    - The task cache is stored in `launchDir/.nextflow/cache/`, organized by session ID. This directory stores metadata associated with your pipeline run <br>

<br>

> [!NOTE]
> Recall when we first launched our pipeline that the `launchDir` was specified as `/workspaces/mdhhs_nextflow_training`.

<br>

For example, let's explore the SEQTK_TRIM task within the work directory. Within the work directory, the unique hash, created from a MD5 checksum, always starts with a two-character prefix followed by the remainder of the hash in a subdirectory. My hash, based on the image above, starts with 86/c94b15 (red box).

<br>

**Your hash pattern to your SEQTK_TRIM task within the work directory will be different.**

<br>

 Navigate to your SEQTK_TRIM task within the work directory and display the contents of the directory:

<br>

```
#Starting from the launchDir
cd work/hash_to/seqtk_trim_task

#For my example in the image, above
work/86/c94b15783c2bb555ef025d7a837a43/

#list contents
ls

#list in long format
ll
```

![SEQTK_TRIM workdir](images/seqtk_work.png)

We notice that the full hash actually consists of 32 hexadecimal characters (the first two characters create the first directory within `work/` (in my example, 86) and the remaining 30 characters represent the sub-directory (in my example, c94b15783c2bb555ef025d7a837a43)). And using the long list command, we see that the input files came from our reads/ directory, which results in the trimmed FASTQ file outputs. 

Challenge: compare the file sizes of the trimmed FASTQ files to the raw FASTQ files to really convince yourself that SRR3747659_SRR3747659_R1_001.fastq.gz and SRR3747659_SRR3747659_R2_001.fastq.gz are the trimmed reads. 

We can see the actual command that was run by looking at the .command.sh file

```
cat .command.sh
```

![.command.sh file](images/command.sh.png)

From the seqtk [GitHub repository](https://github.com/lh3/seqtk), we see the very basic usage of the seqtk trimfq command is as follow:

![SEQTK trimfq](images/seqtk_trimfq.png)

Which is exactly what is occurring in our nextflow pipeline, except with a little more bells and whistles to the command itself. Try copying and pasting the following command into your terminal. 

```
printf "%s\n" SRR3747659_R1_001.fastq.gz SRR3747659_R2_001.fastq.gz | while read f; 
do
    echo $f;
done
```

What is the output?

<details>
<summary>Reveal solution, here</summary>

<br>

SRR3747659_R1_001.fastq.gz <br>
SRR3747659_R2_001.fastq.gz

In other words, this command will loop through each of these files individually and execute the command that follows.
</details>

<br>

So in the nextflow pipeline script for SEQTK, each raw FASTQ file gets trimmed, piped to gzip, and renamed. 

Okay, so hopefully that provides you a little insight into the nextflow resume feature. The checkpoints provided by resume are particularly useful if your pipeline fails halfway through an analysis and you want to restart your pipeline without having to re-analyze everything from the beginning. 

> [!CAUTION] <br>
> Work directories can take up a lot of storage. <br>
> In our work, we delete the work directory once a pipeline successfully completes. <br>

### Exploring Nextflow's system logs 

Let's return to our `launchDir` (`/workspaces/mdhhs_nextflow_training`) 


![return to launhDir](images/return_to_launchdir.png)


and run the following command:

```
nextflow log
```

![nextflow log](images/nextflow_log.png)

We see various information such as:

* TIMESTAMP
    - The files in /workspaces/mdhhs_nextflow_training/results/pipeline_info/ correspond to the timestamp
* COMMAND
    - The actual command run to invoke the nextflow pipeline
* DURATION
    - Again, notice how much faster the resumed pipeline completed compare to the original run
* RUN NAME 
    - The run name is the human-readable form allowing you to simply refer to a pipeline run. Recall that the "runName" was displayed at the pipeline launch. 
* SESSION ID
    - The task cache is organized by this unique session ID to form the basis of the resume feature

<br>

This task cache is located in: 
```
cd .nextflow/cache
ls
```

![Session ID](images/session_id.png)

Again, this `cache` directory and the `work` directory form the basis of the `resume` feature functionality. Altering any of these directories breaks the `resume` feature and your pipeline would just start from the beginning on a subsequent run. 

In summary, all nextflow pipelines are able to be invoked from a single-line command providing nextflow core options and pipeline parameter inputs. <br>

Under the hood, nextflow has been designed as a powerful workflow management system that enables source tracking of all tasks and files created from an analysis. 
 
<br>

## Part III: Obtaining a CDC pipeline from GitHub and performing a test run


Only nf-core community-approved pipelines are stored on nf-core. But, you can also obtain nextflow pipelines from GitHub. And they do not have to abide by nf-core standards. For example, the CDC has created plenty of pipelines that are useful to the public health community. 

Let's take [MIRA-NF](https://github.com/CDCgov/MIRA-NF) as an example. This pipeline can be used for influenza, SARS-CoV-2, or RSV analysis and accepts Illumina and ONT data. First, make a new directory call mira_test and change into that directory:

```
mkdir mira_test
cd mira_test
```

![mkdir mira_test](images/mira_mkdir.png)

Now, git clone the repository. If you navigate to the MIRA-NF GitHub repository link, above, you can select the following items in order to copy the MIRA-NF URL:

![mira url](images/mira_url.png)

On your codespace terminal, enter the following:

```
git clone -b v2.2.1 https://github.com/CDCgov/Mira-nf.git 
```

Where you can paste the URL you copied from the MIRA-NF GitHub repository after "git clone". I also added the branch flag (-b) to specify the release we want to clone. You can find releases on the right panel of the GitHub repository: 

![mira release](images/pipeline_releases.png)

You should see messages indicating that the clone is occurring. And once complete, you should see the repository present on your computer:

```
ls Mira-nf
```

![mira clone](images/mira_clone.png)


You might notice that some of these files and directories in this pipeline look similar to the nf-core-demo pipeline. We'll learn more about these files and directories as we begin to build out our own pipeline in the following tutorials. 

For now, enter the following command to run a built-in test of the pipeline:

```
nextflow run Mira-nf/main.nf \
    -profile docker \
    --e 'Flu-Illumina' \
    --input Mira-nf/tests/test_data/flu_wgs_illumina/samplesheet.csv \
    --outdir results/ \
    --runpath Mira-nf/tests/test_data/flu_wgs_illumina/
```

<br>

> [!NOTE] <br>
> We did not go through and make the sample sheet and obtain FASTQ files (as we did in Part II) because Mira has a built-in test. <br>
> But, do you notice the same main components as mentioned before? <br>
> We see the `nextflow run` command, the path to the `main.nf` file, the `profile` core option, and `input` and `output` parameters <br>
> Plus, a couple of additional inputs that are specific to this pipeline and outlined in the [documentation](https://github.com/CDCgov/MIRA-NF#input-parameters-for-mira-nf-workflows) <br>

<br>

![mira error](images/mira_error.png)

Awesome, another error! In contrast to the error in Part II (computing limitations), this one does not seem as intuitive. <br>

**Group challenge exercise**

And this is a problem with nextflow, at times, when it comes to error reporting. However, take some time with your group and try to resolve the error to get your pipeline running. 


