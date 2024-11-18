process bamindex {
    container 'glebusasha/bwa_samtools'
    publishDir "${params.output}/bamindex"
    tag "$sid"

    input:
    tuple val(sid), path(bamFile)

    output:
    tuple val(sid), path("${sid}.bam.bai"), path(bamFile)

    script:
    """
    samtools index $bamFile
    """

}