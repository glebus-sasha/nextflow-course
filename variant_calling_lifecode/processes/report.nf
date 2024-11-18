process report {
    conda 'bioconda::multiqc'
    container 'staphb/multiqc:latest'
    publishDir "results/report", mode: 'copy'

    input:

    output:

    script:
    """
    multiqc $fastp $flagstat $bcfstats 
    """

}