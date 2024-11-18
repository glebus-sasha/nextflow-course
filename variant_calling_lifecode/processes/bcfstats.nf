process bcfstats {
    container 'staphb/bcftools:latest'
    publishDir "${params.output}/bcfstats"
    tag "$sid"

    input:
    tuple val(sid), path(vcf)

    output:
    tuple val(sid), path("${sid}.bcfstats")

    script:
    """
    bcftools stats $vcf > ${sid}.bcfstats
    """

}