process refindex {
    container 'glebusasha/bwa_samtools'
    publishDir "${params.output}/refindex"
    tag "$reference"

    input:
    path reference

    output:
    path "*"

    script:
    """
    bwa index $reference
    """

}