#!/usr/bin/env nextflow

include { refindex  } from './processes/refindex.nf'
include { qcontrol  } from './processes/qcontrol.nf'
include { align     } from './processes/align.nf'
include { faindex   } from './processes/faindex.nf'
include { bamindex  } from './processes/bamindex.nf'
include { varcall   } from './processes/varcall.nf'
include { flagstat  } from '../variant_calling/processes/flagstat.nf'
include { bcfstats  } from './processes/bcfstats.nf'
include { report    } from './processes/report.nf'

//params.reads        = '../data/*_R{1,2}.fastq'
//params.reference    = '../data/MT.fna'

workflow {
    
}