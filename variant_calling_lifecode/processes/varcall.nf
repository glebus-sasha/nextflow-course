process varcall {
    container 'staphb/bcftools:latest'  
    publishDir "${params.output}/varcall"
    tag "$sid"

    input:
    path reference
    tuple val(sid), path(bamIndex), path(bamFile)
    path faindex

    output:
    tuple val(sid), path("${sid}.vcf")

    script:
    """
    bcftools mpileup -Ou -f $reference $bamFile | bcftools call -mv > ${sid}.vcf
    """

}