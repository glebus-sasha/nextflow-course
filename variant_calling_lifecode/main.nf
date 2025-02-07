#!/usr/bin/env nextflow

include { qcontrol } from './processes/qcontrol.nf'
include { refindex } from './processes/refindex.nf'
include { align } from './processes/align.nf'
include { flagstat } from './processes/flagstat.nf'
include { faindex } from './processes/faindex.nf'
include { bamindex } from './processes/bamindex.nf'
include { varcall } from './processes/varcall.nf'
include { bcfstats } from './processes/bcfstats.nf'
include { report } from './processes/report.nf'

workflow {
    
    reads = Channel.fromFilePairs(params.reads)
    reference = Channel.fromPath(params.reference).collect()
    qcontrol(reads)
    refindex(reference)
    align(reference, qcontrol.out[0], refindex.out)
    faindex(reference)
    bamindex(align.out)
    varcall(reference, bamindex.out, faindex.out)
    bcfstats(varcall.out)
    report(qcontrol.out[1].mix(bcfstats.out).collect())

}