process flagstat {
    conda 'bioconda::bwa bioconda::samtools'
    container = 'glebusasha/bwa_samtools'
    publishDir "results/flagstat"
    tag "$sid"

    input:

    output:

    script:
    """
    samtools flagstat $bamFile > ${sid}.flagstat
    """

}