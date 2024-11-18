process refindex {
    conda 'bioconda::bwa bioconda::samtools'
    container 'glebusasha/bwa_samtools'
    publishDir "results/refindex"
    tag "$reference"

    input:

    output:

    script:
    """
    bwa index $reference
    """

}