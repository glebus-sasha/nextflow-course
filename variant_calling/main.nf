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

workflow  one {
    
    reads = Channel.fromFilePairs(params.reads)
    reference = Channel.fromPath(params.reference).collect()
    qcontrol(reads)
    refindex(reference)
    align(reference, qcontrol.out[0], refindex.out)
    flagstat(align.out)
    faindex(reference)
    bamindex(align.out)
    varcall(reference, bamindex.out, faindex.out)
    bcfstats(varcall.out)
    report(qcontrol.out[2].collect(), flagstat.out.collect(), bcfstats.out.collect())

}

workflow  another {
    
    reference = Channel.fromPath(params.reference).collect()
    
    reference |
    refindex & faindex

    Channel.fromFilePairs(params.reads) | 
    qcontrol

    align(reference, qcontrol.out[0], refindex.out) |
    flagstat & bamindex

    varcall(reference, bamindex.out, faindex.out) |
    bcfstats
    
    report(qcontrol.out[2].collect(), flagstat.out.collect(), bcfstats.out.collect())

}

workflow {
    another()
}