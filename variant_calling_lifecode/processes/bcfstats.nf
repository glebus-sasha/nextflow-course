process bcfstats {
    conda 'bioconda::bcftools'
    container 'staphb/bcftools:latest'
    publishDir "results/bcfstats"
    tag "$sid"

    input:
    tuple val(sid), path(vcf)
    output:
    path("${sid}.bcfstats")
    script:
    """
    bcftools stats $vcf > ${sid}.bcfstats
    """

}