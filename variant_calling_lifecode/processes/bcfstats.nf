process bcfstats {
    conda 'bioconda::bcftools'
    container 'staphb/bcftools:latest'
    publishDir "results/bcfstats"
    tag "$sid"

    input:

    output:

    script:
    """
    bcftools stats $vcf > ${sid}.bcfstats
    """

}