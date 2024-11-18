process faindex {
    conda 'bioconda::bwa bioconda::samtools'
    container 'glebusasha/bwa_samtools'
    publishDir "results/faindex"
    tag "$reference"

    input:

    output:

    script:
    """
    samtools faidx $reference
    """

}