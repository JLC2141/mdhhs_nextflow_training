However, when this occurs, one of this first things I do to troubleshoot the error is to check if someone else has already experienced this error before and reported it as an issue on the GitHub repo. So let's see! <br>

Naviate back to the CDC's Mira [GitHub repo](https://github.com/CDCgov/Mira-nf) and select the `Issues` tab:

![GitHub issues](images/ch_two_sol/git_issue.png)

This is where folks document issues they experience when trying to use a pipeline. Discussions on error resolution with the authors of the pipeline can be seen here. In the search bar, search the following error we recieved: `ERROR ~ Config parsing failed`:

![GitHub issue search](images/ch_two_sol/issue_search.png)

Select on the first option. And if we search and scroll on this particular [issue page](https://github.com/CDCgov/Mira-nf/issues/189):

![GitHub issue resolution](images/ch_two_sol/issue_resolution.png)

We see that the original issue was solved with `export NXF_SYNTAX_PARSER=v1` and that the exact error we just encountered was also documented within this issue showing a similar method for issue resolution. <br>

This may be a good time to introduce nextflow's [strict syntax](https://docs.seqera.io/nextflow/strict-syntax). Remember in the presentation where it was mentioned that Nextflow is a programming language built on [Groovy](https://training.nextflow.io/latest/side_quests/essential_scripting_patterns/), a superset of Java. Now, as nextflow transitions from it's legacy parser to the strict parser, the strict parser only allows for a subset of Groovy syntax for building pipelines in nextflow. <br>

The gist of it is that in Nextflow version 26.04 and later, the strict sytax parser (v2) is turned on by default, and has updated rules as to what syntax is allowed when building nextflow pipleines.  

The workaround solution, which is provided in the [strict syntax](https://docs.seqera.io/nextflow/strict-syntax) documentation (and from the GitHub issue resolution) is to enable nextflow's syntax parser as `v1`:

![Nextflow parser](images/ch_two_sol/nextflow_parser.png)

And we can achieve this by exporting this environmental variable (NXF_SYNTAX_PARSER) in our command line:

```
export NXF_SYNTAX_PARSER=v1
```

![NXF_SYNTAX_PARSER](images/ch_two_sol/nxf_syntax_parser.png)

Now, try re-running the pipeline as we did before:

```
nextflow run Mira-nf/main.nf \
    -profile docker \
    --e 'Flu-Illumina' \
    --input Mira-nf/tests/test_data/flu_wgs_illumina/samplesheet.csv \
    --outdir results/ \
    --runpath Mira-nf/tests/test_data/flu_wgs_illumina/
```

![mira rerun](images/ch_two_sol/mira_rerun.png)


Success!

![mira success](images/ch_two_sol/mira_success.png)

<br>

We will not cover the intricacies of CDC's Mira nextflow pipeline. The point of Part III was to:
1. Demonstrate the ease of obtaining (via `git clone`) and starting a freely available nextflow pipeline that is not from nf-core 
2. Bringing your attention to a very recent syntax change in Nextflow that needs careful evaluation when using nextflow and community pipelines
    - Ask yourself, which nextflow version am I using and does this pipeline abide to strict nextflow syntax?

You may hear terminology such as "refactoring" nextflow pipelines. This means editing current pipelines (typically older pipelines built in Nextflow versions <26.04) so that they stay up-to-date and compatible with updated versions of nextflow, including abiding to strict syntax. Because as you can see from the [strict syntax](https://docs.seqera.io/nextflow/strict-syntax) documentation, eventually the "NXF_SYNTAX_PARSER=v1" option will be phased out in later versions of nextflow. 

![Nextflow parser warning](images/ch_two_sol/nextflow_parser_warning.png)

I'm emphazing this because this change is relatively new (Nextflow 26.04 was released in April of 2026). And as your explore nextflow and public health nextflow pipelines, you have to keep this deatil is mind.  

To use public health pipelines that aren't refactored yet, your options are:
1) Downgrade your nextflow version where syntax parser is v1 by default
2) export NXF_SYNTAX_PARSER=v1 while it's still available as an option in Nextflow v26.04.XX


![Edit Dockerfile before](images/ch_two_sol/edit_dockerfile_before.png)

Add the following line to your `Dockerfile`:

```
ENV NXF_SYNTAX_PARSER=v1
```

Save the file:

```
ctrl + s
```

![Edit Dockerfile after](images/ch_two_sol/edit_dockerfile_after.png)


Select `F1` and search `Rebuild container` in the command pallette, select that option:

![Rebuild devcontainer](images/ch_two_sol/rebuild_devcontainer.png)

And select `Full rebuild`:


![Full rebuild](images/ch_two_sol/full_rebuild.png)

Your codespace will launch again from scratch, but rebuild with the new edit to our Dockerfile. Once relaunched, if you entered the command:

```
echo $NXF_SYNTAX_PARSER
```

![Echo parser](images/ch_two_sol/echo_parser.png)





