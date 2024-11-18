process align {
    conda 'bioconda::bwa bioconda::samtools'
    container 'glebusasha/bwa_samtools'
    publishDir "results/align"
    tag "$sid"

    input:

    output:

    script:
    """
    bwa mem \
        ${reference} ${reads1} ${reads2} | \
        samtools view -bh | \
        samtools sort -o ${sid}.bam
    """

}