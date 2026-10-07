process READITANDKEEP {
    tag "$meta.id"
    label 'process_low'

    // TODO nf-core: See section in main README for further information regarding finding and adding container addresses to the section below.
    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine in ['singularity', 'apptainer'] && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/read-it-and-keep:0.3.0--h5ca1c30_3':
        'ghcr.io/globalpathogenanalysisservice/read-it-and-keep:v0.3.0' }"

    input:// TODO nf-core: Where applicable all sample-specific information e.g. "id", "single_end", "read_group"
    //               MUST be provided as an input via a Groovy Map called "meta".
    //               This information may not be required in some instances e.g. indexing reference genome files:
    //               https://github.com/nf-core/modules/blob/master/modules/nf-core/bwa/index/main.nf
    // TODO nf-core: Where applicable please provide/convert compressed files as input/output
    //               e.g. "*.fastq.gz" and NOT "*.fastq", "*.bam" and NOT "*.sam" etc.
    tuple val(meta), path(reads)
    path(reference)

    output:
    // TODO nf-core: Named file extensions MUST be emitted for ALL output channels
    tuple val(meta), path("*.fastq.gz")
    path "*_scrubbed_results.txt"
    tuple val("${task.process}"), val('readitandkeep'), eval("readItAndKeep --version"), topic: versions, emit: versions_readitandkeep

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    readItAndKeep \\
        --ref_fasta $reference \\
        --reads1 ${prefix}_R1_001.fastq.gz \\
        --reads2 ${prefix}_R2_001.fastq.gz \\
        --outprefix ${prefix} \\
        $args \\
        > ${prefix}_scrubbed_results.txt
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    // TODO nf-core: A stub section should mimic the execution of the original module as best as possible
    //               Have a look at the following examples:
    //               Simple example: https://github.com/nf-core/modules/blob/624977dfaf562211e68a8a868ca80acc8461f1ac/modules/nf-core/cutadapt/main.nf#L34-L46
    //               Complex example: https://github.com/nf-core/modules/blob/88d43dad73a675e66bff49ebb57fe657a5909018/modules/nf-core/bedtools/split/main.nf#L32-L43
    // TODO nf-core: If the module doesn't use arguments ($args), you SHOULD remove:
    //               - The definition of args `def args = task.ext.args ?: ''` above.
    //               - The use of the variable in the script `echo $args ` below.
    """
    echo $args
    
    touch ${prefix}.bam
    """
}
