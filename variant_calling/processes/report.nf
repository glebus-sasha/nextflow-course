process report {
    conda 'bioconda::multiqc'
    container 'staphb/multiqc:latest'
    publishDir "results/report", mode: 'copy'

    input:
    path fastp
    path flagstat
    path bcfstats

    output:
    path 'multiqc_report.html', emit: html

    script:
    """
    multiqc $fastp $flagstat $bcfstats 
    """

}