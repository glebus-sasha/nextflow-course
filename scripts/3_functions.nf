#!/usr/bin/env nextflow

def add(a, b) {
    return a + b
}

workflow {
    println(add(5, 7))
}