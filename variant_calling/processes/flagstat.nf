process flagstat {
    
    container = 'glebusasha/bwa_samtools'
    publishDir "results/flagstat"
    tag "$sid"

    input:
    tuple val(sid), path(bamFile)

    output:
    path "${sid}.flagstat"

    script:
    """
    samtools flagstat $bamFile > ${sid}.flagstat
    """

}