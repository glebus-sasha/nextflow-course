process bamindex {
    conda 'bioconda::bwa bioconda::samtools'
    container 'glebusasha/bwa_samtools'
    publishDir "results/bamindex"
    tag "$sid"

    input:

    output:

    script:
    """
    samtools index ${bamFile}
    """

}