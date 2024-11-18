process qcontrol {
    conda 'bioconda::fastp'
    container 'nanozoo/fastp:0.23.1--9f2e255'
    publishDir "results/qcontrol"
    tag "$sid"
    memory '2 GB'

    input:

    output:

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