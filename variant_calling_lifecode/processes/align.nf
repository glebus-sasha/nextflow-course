process align {
    container 'glebusasha/bwa_samtools'
    publishDir "${params.output}/align"
    tag "$sid"

    input:
    path reference
    tuple val(sid), path(reads1), path(reads2)
    path idx

    output:
    tuple val(sid), path("${sid}.bam")

    script:
    """
    bwa mem \
        ${reference} ${reads1} ${reads2} | \
        samtools view -bh | \
        samtools sort -o ${sid}.bam
    """

}