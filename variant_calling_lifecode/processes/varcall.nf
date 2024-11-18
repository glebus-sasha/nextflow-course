process varcall {
    conda 'bioconda::bcftools'
    container 'staphb/bcftools:latest'
    publishDir "results/varcall"
    tag "$sid"

    input:

    output:

    script:
    """
    bcftools mpileup -Ou -f $reference $bamFile | bcftools call -mv > ${sid}.vcf
    """

}