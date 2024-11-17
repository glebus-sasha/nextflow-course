process report {
    
    container = 'staphb/multiqc:latest'
    publishDir "results/report"

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