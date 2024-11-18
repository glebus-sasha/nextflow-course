process faindex {
    container 'glebusasha/bwa_samtools'
    publishDir "${params.output}/faindex"
    tag "$reference"

    input:
    path reference

    output:
    path "${reference}.fai"

    script:
    """
    samtools faidx $reference
    """

}