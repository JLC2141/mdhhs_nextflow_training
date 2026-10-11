process READITANDKEEP {
    tag "$meta.id"
    label 'process_low'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine in ['singularity', 'apptainer'] && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/read-it-and-keep:0.3.0--h5ca1c30_3':
        'quay.io/biocontainers/read-it-and-keep:0.3.0--h5ca1c30_3' }"

    input:
    tuple val(meta), path(reads)
    path(reference)

    output:
    tuple val(meta), path('*.fastq.gz')
    path('*_scrubbed_results.txt')
    tuple val("${task.process}"), val('readitandkeep'), eval("readItAndKeep --version"), topic: versions, emit: versions_readitandkeep

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    readItAndKeep \\
        --ref_fasta $reference \\
        --reads1 ${reads[0]} \\
        --reads2 ${reads[1]} \\
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
