process refindex {
    conda 'bwa samtools'
    container 'glebusasha/bwa_samtools'
    publishDir "results/refindex"
    tag "$reference"

    input:
    path reference

    output:
    path "${reference}.*"

    script:
    """
    bwa index $reference
    """

}