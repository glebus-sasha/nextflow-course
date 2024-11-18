process flagstat {
    container 'glebusasha/bwa_samtools'
    publishDir "${params.output}/flagstat"
    tag "$sid"

    input:
    tuple val(sid), path(bamFile)

    output:
    tuple val(sid), path("${sid}.flagstat")

    script:
    """
    samtools flagstat $bamFile > ${sid}.flagstat
    """

}