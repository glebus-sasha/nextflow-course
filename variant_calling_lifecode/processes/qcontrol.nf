process qcontrol {
    container 'nanozoo/fastp:0.23.1--9f2e255'
    publishDir "${params.output}/fastp", mode: 'copy'
    tag "$sid"
    memory '2 GB'

    input:
    tuple val(sid), path(reads)

    output:
    tuple val(sid), path("${reads[0]}"), path("${reads[1]}")
    path "${sid}.fastp_stats.html"
    path "${sid}.fastp_stats.json"

    script:
    """
    fastp \
        --in1 ${reads[0]} \
        --in2 ${reads[1]}\
        --out1 "${sid}_R1" \
        --out2 "${sid}_R2" \
        --html ${sid}.fastp_stats.html \
        --json ${sid}.fastp_stats.json  
    """

}