#!/usr/bin/env nextflow
process my_process {
    debug true

    input:
    val x
    val y

    output:
    stdout

    script:
    """
    echo "x: ${x}, y: ${y}, x*y: ${x * y}"
    """
}

workflow{
    ch1 = channel.from(1,2,3,4)
    ch2 = channel.value(10)
    my_process(ch1, ch2)
}