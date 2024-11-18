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
    
//    reads = 
//    reference = 
//    qcontrol
//    refindex
//    align
//    flagstat
//    faindex
//    bamindex
//    varcall
//    bcfstats
//    report

}