# Nextflow course — code blocks

## Code block 001

```
git clone https://github.com/glebus-sasha/nextflow-course.git
```

## Code block 002

```
nextflow self-update
```

## Code block 003

```
export NXF_VER=26.10.3 
nextflow -v
```

## Code block 004

```
cd nextflow-course
nextflow run hello
```

## Code block 005

```
#!/usr/bin/env nextflow

println 'Hello world!' // line comment
```

## Code block 006

```
chmod +x 1.hello_world.nf
./1.hello_world.nf 
```

## Code block 007

```
ls -lha
```

## Code block 008

```
#!/usr/bin/env nextflow

def x = Math.random()
if( x < 0.5 ) {
    println 'You lost...'
}
else {
    println 'You won!'
}
```

## Code block 009

```
#!/usr/bin/env nextflow

def add(a, b) {
    return a + b
}

workflow {
    println(add(5, 7))
}
```

## Code block 010

```
params.reads = 'data/*_R{1,2}.fastq'
reads = channel.fromFilePairs(params.reads)
```

## Code block 011

```
params.reference = '../data/MT.fna'
reference = channel.fromPath(params.reference)
```

## Code block 012

```
process refindex {
    input:
    path reference
    
    output:
    path "*"
    
    script:
    """
    bwa index $reference
    """
}
```

## Code block 013

```
    fastp \
        --in1 ${reads[0]} \
        --in2 ${reads[1]} \
        --out1 "${sid}_trimmed_R1.fq" \
        --out2 "${sid}_trimmed_R2.fq" \
        --html ${sid}.fastp_stats.html \
        --json ${sid}.fastp_stats.json   
```

## Code block 014

```
conda 'bioconda::bwa'
conda 'bioconda::fastp'
```

## Code block 015

```
include { refindex } from './processes/refindex.nf'
include { qcontrol } from './processes/qcontrol.nf'
```

## Code block 016

```
mkdir -p "$HOME/.apptainer" && echo 'export NXF_APPTAINER_CACHEDIR="$HOME/.apptainer"' >> ~/.bashrc && source ~/.bashrc
```

## Code block 017

```
wave.enabled = true
```

## Code block 018

```
params.reads        = "${projectDir}/data/*_R{1,2}.fastq.gz"
params.reference    = "${projectDir}/data/MT.fna"
```

## Code block 019

```
profiles {
    conda {
        conda.enabled       = true
    }
    mamba {
        conda.enabled       = true
        conda.useMamba      = true
    }
    docker {
        docker.enabled       = true
    }
    apptainer {
        apptainer.enabled       = true
    }
    singularity {
        singularity.enabled       = true
    }
}
```

## Code block 020

```
git add .
git commit -m "do"
git push
```

## Code block 021

```
mkdir nextflow-course-my-launch
cd nextflow-course-my-launch/
export GITHUB_USERNAME="your-github-username"
nextflow run "$GITHUB_USERNAME/nextflow-course-my" -r full -profile apptainer
```

## Code block 022

```
workflow {
    reads = channel.fromFilePairs(params.reads)
    reference = channel.fromPath(params.reference).collect()
    refprepare(reference)
    align_varcall(reference,refprepare.out.refindex, reads)
}
```

## Code block 023

```
conda install nf-core
```

## Code block 024

```
pip install nf-core
```

## Code block 025

```
shell	shell config file	command
bash	~/.bashrc	eval "$(_NF_CORE_COMPLETE=bash_source nf-core)"
zsh	~/.zshrc	eval "$(_NF_CORE_COMPLETE=zsh_source nf-core)"
fish	~/.config/fish/completions/nf-core.fish	eval (env _NF_CORE_COMPLETE=fish_source nf-core)
```

## Code block 026

```
https://nf-co.re/docs/nf-core-tools/cli/installation
```

## Code block 027

```
mkdir sarek_test
cd sarek_test/
nextflow run nf-core/sarek -profile test,apptainer --outdir results
```

## Code block 028

```
WARN: Cannot read project manifest -- Cause: API rate limit exceeded -- Provide your GitHub user name and password to get a higher rate limit
API rate limit exceeded -- Provide your GitHub user name and password to get a higher rate limit
```

## Code block 029

```
export GITHUB_TOKEN="ghp_ТВОЙ_ТОКЕН"
nextflow pull nf-core/sarek
```

## Code block 030

```
$HOME/.nextflow/assets/nf-core
```

## Code block 031

```
nf-core pipelines list
```

## Code block 032

```
nano custom.config
```

## Code block 033

```
process {
  resourceLimits = [
    cpus: 6,
    memory: 3.GB,
    time: 24.h
  ]
withName: 'BWAMEM1_MEM' {
    cpus = 2
    memory = 3.GB
  }
}
```

## Code block 034

```
nextflow run nf-core/sarek -profile test,apptainer --outdir results -c custom.config -resume
```

## Code block 035

```
find "$HOME/.nextflow/assets" -path '*/sarek/tests/csv/*/fastq_single.csv' -print
```

## Code block 036

```
mkdir sarek_launch
cd sarek_launch
nano samplesheet.csv
```

## Code block 037

```
patient,sample,lane,fastq_1,fastq_2
patient1,sample1,lane1,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample1_R1.fastq.gz,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample1_R2.fastq.gz
patient2,sample2,lane2,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample2_R1.fastq.gz,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample2_R2.fastq.gz
patient3,sample3,lane3,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample3_R1.fastq.gz,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample3_R2.fastq.gz
patient4,sample4,lane4,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample4_R1.fastq.gz,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample4_R2.fastq.gz
patient5,sample5,lane5,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample5_R1.fastq.gz,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample5_R2.fastq.gz
patient6,sample6,lane6,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample6_R1.fastq.gz,https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/sample6_R2.fastq.gz
```

## Code block 038

```
https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/samplesheet_nfcoreintro.csv
```

## Code block 039

```
nf-core pipelines launch sarek
```

## Code block 040

```
nano params.yaml
```

## Code block 041

```
input           : samplesheet.csv
outdir          : results
fasta           : https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/MT.fna
igenomes_ignore : true
skip_tools      : baserecalibrator
no_intervals    : true
```

## Code block 042

```
nextflow run nf-core/sarek -r 3.10.0 -profile apptainer -resume -params-file nf-params.json -c custom.config 
```

## Code block 043

```
{
    "input": "results/csv/markduplicates_no_table.csv",
    "step": "variant_calling",
    "outdir": "results",
    "tools": "mpileup",
    "fasta": "https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/MT.fna",
    "no_intervals": true
}
```

## Code block 044

```
python3 -m http.server 8000
```

## Code block 045

```
{
    "input": "results/csv/variantcalled.csv",
    "step": "annotate",
    "outdir": "results",
    "tools": "snpeff",
    "no_intervals": true
}
```

## Code block 046

```
nf-core pipelines create
```

## Code block 047

```
nano template.yml
```

## Code block 048

```
name: nfcoreintro
description: Introduction to Nextflow and nf-core
author: Your Name
org: your-github-username
version: 1.0.0dev
outdir: nfcoreintro
force: true
is_nfcore: false

skip_features: []
```

## Code block 049

```
mkdir -p nfcoreintro
```

## Code block 050

```
nf-core pipelines create --template-yaml  template.yml
```

## Code block 051

```
export GITHUB_USERNAME="your-github-username"
git remote add origin "https://github.com/${GITHUB_USERNAME}/nfcoreintro.git"
```

## Code block 052

```
git push --all origin
```

## Code block 053

```
cd nfcoreintro
mkdir testing
cd testing
```

## Code block 054

```
nextflow run .. -profile test,apptainer --outdir results -c custom.config -resume
```

## Code block 055

```
nf-core pipelines lint
```

## Code block 056

```
git checkout dev
```

## Code block 057

```
input  = 'https://raw.githubusercontent.com/glebus-sasha/nextflow-course-template/refs/heads/main/data/samplesheet_nfcoreintro.csv'
```

## Code block 058

```
nextflow run .. -profile apptainer,test --outdir results -resume -c custom.config
```

## Code block 059

```
git add .
git commit -m 'add: fastp'
```

## Code block 060

```
nf-core modules remove fastqc
```

## Code block 061

```
nf-core pipelines lint
```

## Code block 062

```
    withName: FASTQC {
        ext.args = '--quiet'
    }
```

## Code block 063

```
git add .
git commit -m "fix config"
```

## Code block 064

```
nf-core pipelines lint --dir . --fix container_configs
```

## Code block 065

```
nf-core pipelines lint
```

## Code block 066

```
nf-core modules install bwa/mem
```

## Code block 067

```
    //
    // MODULE: Run bwa mem
    //
    BWA_MEM (
        ch_trimmed_reads,
        bwa_index,
        fasta,
        true
    )
    ch_bam              = BWA_MEM.out.bam
```

## Code block 068

```
withName: 'BWA_MEM' {
    cpus = 2
    memory = 3.GB
}
```

## Code block 069

```
nf-core pipelines schema build

```

## Code block 070

```
nf-core modules install samtools/index
```

## Code block 071

```
    //
    // MODULE: Run samtools index
    //
    SAMTOOLS_INDEX (
        ch_bam
    )
    ch_bai              = SAMTOOLS_INDEX.out.index
```

## Code block 072

```
nf-core modules install samtools/flagstat
```

## Code block 073

```
    //
    // MODULE: Run flagstat
    //
    ch_aligment = ch_bam.join(ch_bai)
    SAMTOOLS_FLAGSTAT (
        ch_aligment
    )
    ch_multiqc_files    = ch_multiqc_files.mix(SAMTOOLS_FLAGSTAT.out.flagstat.collect{it[1]})
```

## Code block 074

```
nf-core modules install bcftools/mpileup
```

## Code block 075

```
    //
    // MODULE: Run bcftools mpileup
    //
    ch_varcall_input = ch_bam.map { meta, bam -> [meta, bam, [], []] }
    ch_fasta_fai = fasta.map { meta, file -> [meta, file, []] }
    BCFTOOLS_MPILEUP (
        ch_varcall_input,
        ch_fasta_fai,
        false
    )
    ch_multiqc_files    = ch_multiqc_files.mix(BCFTOOLS_MPILEUP.out.stats.collect{it[1]})
```

## Code block 076

```
withName: 'BCFTOOLS_MPILEUP' {
    ext.args    = '-Ou'
    ext.args2   = '-m'
}
```

## Code block 077

```
git add .
git commit -m "add: mpileup"
```

## Code block 078

```
git push
```

## Code block 079

```
git push -u origin master
```

## Code block 080

```
git push -u origin TEMPLATE
```

## Code block 081

```
nf-test test --profile test,apptainer --update-snapshot
```

## Code block 082

```
nf-test test --profile test,apptainer
```

