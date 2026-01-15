# Key Concepts of Nextflow

<!-- TOC -->
<!-- /TOC -->

## Table of Contents
- [Key Concepts of Nextflow](#key-concepts-of-nextflow)
  - [Table of Contents](#table-of-contents)
  - [1. Part one](#1-part-one)
    - [1. Installation](#1-installation)
    - [2. Nextflow syntax](#2-nextflow-syntax)
    - [3. Channels](#3-channels)
      - [Creating Channels](#creating-channels)
      - [Types of Channels](#types-of-channels)
    - [4. Operators](#4-operators)
      - [Key Operators:](#key-operators)
    - [5. Processes](#5-processes)
      - [Process Structure](#process-structure)
      - [Key Directives:](#key-directives)
    - [6. Factories](#6-factories)
      - [Key Factories:](#key-factories)
  - [2. Part two](#2-part-two)
    - [1. Структура репозитория nf-core](#1-структура-репозитория-nf-core)
      - [2. Структура папки modules (пример)](#2-структура-папки-modules-пример)
      - [3. Структура папки subworkflows](#3-структура-папки-subworkflows)
      - [4. Структура папки conf](#4-структура-папки-conf)
      - [5. Test datasets](#5-test-datasets)
      - [6. nf-core pipeline template](#6-nf-core-pipeline-template)
      - [7. Фактория для входного samplesheet (пример)](#7-фактория-для-входного-samplesheet-пример)
      - [8. Структура модуля](#8-структура-модуля)
      - [9. Добавление нового модуля](#9-добавление-нового-модуля)
      - [10. Добавление нового параметра](#10-добавление-нового-параметра)

## 1. Part one 

### 1. Installation
- [Install Nextflow](https://www.nextflow.io/docs/latest/install.html)
- [Install Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)
- [Install Mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html)
- [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Install Apptainer ](https://apptainer.org/docs/admin/main/installation.html)
- [Install Singularity](https://github.com/apptainer/singularity/blob/master/INSTALL.md?ysclid=m6mchtlk2e332906599)
- [Install Docker](https://docs.docker.com/engine/install/)
- [Install Nextflow](https://www.nextflow.io/docs/latest/install.html)

### 2. Nextflow syntax
[Nextflow syntax](https://www.nextflow.io/docs/latest/reference/syntax.html)

### 3. Channels
Channels are the foundation of Nextflow. They are used to pass data between processes.

#### Creating Channels
Channels are created using functions:
- `Channel.from(...)` — creates a channel from a list of values.
- `Channel.of(...)` — creates a channel from one or more values.
- `Channel.fromPath(...)` — creates a channel from files matching a given path.

```nextflow
// Create a channel from a list of numbers
ch = Channel.from(1, 2, 3, 4, 5)
```

```nextflow
// Create a channel from files
files = Channel.fromPath("data/*.fastq")
```

#### Types of Channels
- **Value channel**: contains a single value.
- **Queue channel**: can pass a stream of data.

### 4. Operators
Operators are applied to channels to modify their content.

#### Key Operators:
- `map` — transforms data within a channel.
- `filter` — keeps only elements that satisfy a condition.
- `combine` — merges two channels.
- `join` — joins two channels based on a key.

```nextflow
// Apply map to multiply each element by 2
ch.map { it * 2 }
```

```nextflow
// Keep only even numbers
ch.filter { it % 2 == 0 }
```

```nextflow
// Merge two channels
ch1 = Channel.from(1, 2, 3)
ch2 = Channel.from("A", "B", "C")
ch1.combine(ch2)
```

### 5. Processes
Processes are the main building blocks of Nextflow. They define computations.

#### Process Structure
```nextflow
process EXAMPLE {
    input:
    val x  // Accepts variable x
    
    output:
    val result  // Returns result
    
    script:
    result = x * 2
}
```

#### Key Directives:
- `input:` — process input data.
- `output:` — process output data.
- `script:` — code to execute.

### 6. Factories
Factories help process data streams.

#### Key Factories:
- `collect` — gathers all elements into a list.
- `flatten` — flattens a list.

```nextflow
ch = channel.from([1, [2, 3], 4])
ch.flatten() // Result: [1, 2, 3, 4]
```

## 2. Part two

### 1. Структура репозитория nf-core

```
.
├── CHANGELOG.md             # A chronological log of changes made to the pipeline across versions.
├── CITATIONS.md             # References and citations for tools, methods, and datasets used in the pipeline.
├── LICENSE                  # The license file specifying terms under which the pipeline is distributed.
├── README.md                # The main overview and documentation for the pipeline, including usage instructions.
├── assets                   # Templates and static resources used by the pipeline for reports, emails, and schema files.
│   └── ...
├── conf                     # Nextflow configuration profiles for different environments and purposes.
│   └── ...
├── docs                     # Extended documentation for end users.
│   ├── README.md            # Introduction and overview of documentation.
│   ├── output.md            # Explanation of pipeline outputs and directory structure.
│   └── usage.md             # Detailed usage guide and example commands.
├── main.nf                  # The main entrypoint for the pipeline.
├── modules                  # Collection of nf-core/modules used by the pipeline.
│   ├── local                # Modules written specifically for this pipeline.
│   └── nf-core              # Modules imported from nf-core collections.
├── modules.json             # Version-locked manifest of modules used in the pipeline.
├── nextflow.config          # Top-level default configuration loaded by Nextflow on pipeline start.
├── nextflow_schema.json     # Formal JSON schema describing all pipeline parameters.
├── nf-test.config           # Configuration file for nf-test integration testing framework.
├── ro-crate-metadata.json   # RO-Crate metadata describing pipeline provenance and structure.
├── subworkflows             # Reusable workflow components composed of multiple modules.
│   ├── local                # Subworkflows written specifically for this pipeline.
│   └── nf-core              # Subworkflows imported from nf-core collections.
├── tests                    # Automated nf-test test suites for validating pipeline behavior.
│   ├── default.nf.test      # Main test definitions written in nf-test syntax.
│   ├── default.nf.test.snap # Snapshot files used for output comparison.
│   └── nextflow.config      # Test-specific Nextflow configuration.
├── tower.yml                # Configuration for monitoring and launching pipelines via Nextflow Tower.
└── workflows                # High-level workflow definitions.
    └── <workflow_name>.nf   # The main workflow, defining workflow logic.
```

[Подробнее](https://nf-co.re/docs/contributing/pipelines/pipeline_file_structure)

#### 2. Структура папки modules (пример)

```
modules                          # Collection of nf-core/modules used by the pipeline.
├── local                        # Modules written specifically for this pipeline.
│   ├── bracken_results          # Module for handling Bracken results.
│   │   └── main.nf              # Main process file for the bracken_results module.
└── nf-core                      # Namespaced directory containing imported nf-core modules.
    ├── bracken                  # nf-core Bracken module.
    │   └── bracken              # Subdirectory containing Bracken workflow files.
    │       ├── environment.yml  # Conda environment specification for Bracken module.
    │       ├── main.nf          # Main process file for Bracken module.
    │       ├── meta.yml         # Metadata describing Bracken module parameters and inputs.
    │       └── tests            # Test definitions for Bracken module.
    │           └── ...          # Test files and snapshots.
    ├── cat                      # nf-core Cat module.
    │   └── fastq                # Subdirectory containing Cat fastq workflow files.
    │       ├── environment.yml  # Conda environment specification for Cat fastq module.
    │       ├── main.nf          # Main process file for Cat fastq module.
    │       └── meta.yml         # Metadata describing Cat fastq module parameters and inputs.

```

#### 3. Структура папки subworkflows

```
subworkflows                                 # Reusable workflow components composed of multiple modules.
├── local                                    # Subworkflows written specifically for this pipeline.
│   └── compare_taxonomy.nf                  # Workflow for comparing taxonomy.
└── nf-core                                  # Subworkflows imported from nf-core collections.
    ├── utils_nextflow_pipeline              # Utility subworkflow for Nextflow pipelines.
    │   ├── main.nf                          # Main workflow logic for utils_nextflow_pipeline.
    │   ├── meta.yml                         # Metadata describing parameters and inputs of the subworkflow.
    │   └── tests                            # Automated test suites for validating the subworkflow.
    │       ├── main.function.nf.test        # Test for function-level components.
    │       ├── main.function.nf.test.snap   # Snapshot for function-level test output comparison.
    │       ├── main.workflow.nf.test        # Test for the overall workflow.
    │       ├── nextflow.config              # Test-specific Nextflow configuration.
    │       └── tags.yml                     # Tag definitions for tests.
    │       └── ...                          # Additional test files, if any.

```

#### 4. Структура папки conf

```
conf                        # Nextflow configuration profiles for different environments and purposes.
├── base.config             # Base/default configuration with global process directives.
├── igenomes.config         # Configuration for iGenomes reference datasets.
├── igenomes_ignored.config # Configuration specifying no iGenomes datasets to be used.
├── modules.config          # Configuration for module-specific settings.
├── test.config             # Simple test configuration for pipeline validation.
└── test_full.config        # Full test configuration using real data for comprehensive validation.
```

[Что такое igenomes?](https://support.illumina.com/sequencing/sequencing_software/igenome.html)

#### 5. Test datasets

Написание пайплайна стоит начать с подборка или создания тестовых данных.
Прежде всего стоит обратить на nf-core/test-datasets - репозиторий, содержащий готовые samplesheets, ссылающиеся на готовые тестовые данные. Для каждого пайплайна созданы различные ветки. Лучше, если возможно переиспользовать тестовые данные, а не создавать новые.

Например, когда мы создам новый пайплайн с помощью `nf-core piplines create`, у нас в `conf/test.config` есть строка:

```
    input  = params.pipelines_testdata_base_path + 'viralrecon/samplesheet/samplesheet_test_illumina_amplicon.csv'
```
pipelines_testdata_base_path по умолчанию указан в `nextflow.config`

```
    pipelines_testdata_base_path = 'https://raw.githubusercontent.com/nf-core/test-datasets/'
```

в итоге получается путь
```
https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/samplesheet/samplesheet_test_illumina_amplicon.csv
```

этот файл содержит

```
sample,fastq_1,fastq_2
SAMPLE1_PE,https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/illumina/amplicon/sample1_R1.fastq.gz,https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/illumina/amplicon/sample1_R2.fastq.gz
SAMPLE2_PE,https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/illumina/amplicon/sample2_R1.fastq.gz,https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/illumina/amplicon/sample2_R2.fastq.gz
SAMPLE3_SE,https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/illumina/amplicon/sample1_R1.fastq.gz,
SAMPLE3_SE,https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/illumina/amplicon/sample2_R1.fastq.gz,
```
где 
- `sample` - название образца
- `fastq_1` - полный путь до файла содержащего 1 риды
- `fastq_2` - полный путь до файла содержащего 2 риды, если парные прочтения, иначе пусто

Обратите внимание, что что полный путь до файла, может ссылаться как на репозиторий `test-datasets`, так и на ваш репозиторий. Можно указывать путь и до локальных данных, но это не рекомендуется для тестового запуска.

[Подробнее](https://nf-co.re/docs/tutorials/tests_and_test_data/test_data)

#### 6. nf-core pipeline template

При создании нового пайплайна, с помощью `nf-core piplines create`, создается стандартный шаблон.

Главный файл, в корне репозитория `main.nf` содержит описание workflow главного анализа в формате 
```
workflow <ORG_NAME>_<PIPELINE_NAME> {
   ...
   workflow <PIPELINE_NAME>{
   ...
   }
   ...
}
```
Где <PIPELINE_NAME> прописан в `workflows/<pipeline_name>.nf` - **это основной файл, содержащий ваш анализ**.

Ниже - главный (безымянный) workflow используется как точка входа, и он содержит:
```
workflow {
   PIPELINE_INITIALISATION (
      ...
   )
   <ORG_NAME>_<PIPELINE_NAME> (
      ...
   )
   PIPELINE_COMPLETION (
      ...
   )
}
```

`PIPELINE_INITIALISATION` и `PIPELINE_COMPLETION` прописаны в `subworkflows/local/utils_nfcore_<pipeline_name>_pipeline/main.nf`. 

В этом же файле:
- импорт общих функции, subworkflows (напр. из  `subworkflows/nf-core/utils_nfcore_pipeline`)
- `PIPELINE_INITIALISATION`: валидация параметров и schema-проверки, **создание факторий из входных параметров**
- `PIPELINE_COMPLETION`: поведение при успешном, неуспешном завершении пайплайна (вывести сообщение / отправить email)
- дополнительные функции, созданные для вашего пайплайна

#### 7. Фактория для входного samplesheet (пример)

При создании нового пайплайна, с помощью `nf-core piplines create`, создается стандартный шаблон, с файлом `subworkflows/local/utils_nfcore_<pipeline_name>_pipeline/main.nf`, который содержит 

```
Channel
   # Create a channel from a list generated by parsing the input samplesheet according to a JSON schema.
   .fromList(samplesheetToList(params.input, "${projectDir}/assets/schema_input.json"))  
   # Map over each row of the samplesheet, extracting metadata and FASTQ files.
   .map { meta, fastq_1, fastq_2 -> 
         # If only one FASTQ file is present, mark it as single-end and wrap it in a list.
         if (!fastq_2) {  
            return [ meta.id, meta + [ single_end:true ], [ fastq_1 ] ]
         # If two FASTQ files are present, mark as paired-end and include both in a list.
         } else {  
            return [ meta.id, meta + [ single_end:false ], [ fastq_1, fastq_2 ] ] 
         }  
      }
      # Group channel elements into tuples keyed by metadata ID.
      .groupTuple()      
      # Validate the grouped samplesheet for correctness and completeness.                
      .map { samplesheet ->
         validateInputSamplesheet(samplesheet)
      }
      # Flatten the list of FASTQ files to simplify downstream processing.
      .map { meta, fastqs ->  
         return [ meta, fastqs.flatten() ]  
      }
      .map { meta, reads -> [ meta, reads, [] ] }  
      # Assign the resulting channel to the variable 'ch_samplesheet' for downstream usage.
      .set { ch_samplesheet }
```

Не стесняйтесь использовать оператор view() построчно, чтобы проследить, какие изменения претерпевают каналы, а так же меняйте факторию по своему усмотрению.

Ниже добавляются фактории для доп параметров, если они вам нужны.

#### 8. Структура модуля

Рассмотрим типичную структуру модуля.

Шапка:
```
process BWA_MEM {
   tag "$meta.id"
   label 'process_high'

   conda "${moduleDir}/environment.yml"
   container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
      'https://community-cr-prod.seqera.io/docker/registry/v2/blobs/sha256/d7/d7e24dc1e4d93ca4d3a76a78d4c834a7be3985b0e1e56fddd61662e047863a8a/data' :
      'community.wave.seqera.io/library/bwa_htslib_samtools:83b50ff84ead50d0' }"

...
```
- `BWA_MEM` - название модуля в snake_case с указанием программы и команды.
- `tag` - то, что будет отображаться в консоли. Как правило пишется название обрабатываемого файла. 
- [Подробнее о label](https://nf-co.re/docs/usage/getting_started/configuration#tuning-workflow-resources)
- `conda` - описание окружния conda. Как правило ссылается на файл environment.yml, содержащийся в той же директории что и main.nf модуля. [Подробнее об environment.yml](https://docs.conda.io/projects/conda/en/stable/user-guide/tasks/manage-environments.html#)
- `container` указывает на контейнет, который нужно пуллить. При этом если движок singularity (apptainer), то пуллится уже готовый sif file. `singularity_pull_docker_container = true` указывается в файле `conf/modules.config`, как `ext.args`, в случае, если хочется конвертировать докер-контейнер в sif при использовании движка singularity (apptainer). Обратите внимание, что рекомендуется использовать sha pulling, а не tag pulling, чтобы гарантировать воспроизводимость. 

Входы, выходы, when:

```
   input:
   tuple val(meta) , path(reads)
   tuple val(meta2), path(index)
   tuple val(meta3), path(fasta)
   val   sort_bam

   output:
   tuple val(meta), path("*.bam")  , emit: bam,    optional: true
   tuple val(meta), path("*.cram") , emit: cram,   optional: true
   tuple val(meta), path("*.csi")  , emit: csi,    optional: true
   tuple val(meta), path("*.crai") , emit: crai,   optional: true
   path  "versions.yml"            , emit: versions

   when:
   task.ext.when == null || task.ext.when
```

- `input`: по возможности использовать кортежи с метаинформацией общепринятой формы.
- `output`: используем именованные выходы, с помощью emit, так же помечаем опциональные выходы. Всегда добавляем выход, содержащий файл `versions.yml` с версиями использованных программ.
- `when`: устарел, для обратной совместимости вынесен в файл `conf/modules.config`, как `ext.args`

script:

```
   script:
   def args = task.ext.args ?: ''
   def args2 = task.ext.args2 ?: ''
   def prefix = task.ext.prefix ?: "${meta.id}"
   def samtools_command = sort_bam ? 'sort' : 'view'
   def extension = args2.contains("--output-fmt sam")   ? "sam" :
                  args2.contains("--output-fmt cram")  ? "cram":
                  sort_bam && args2.contains("-O cram")? "cram":
                  !sort_bam && args2.contains("-C")    ? "cram":
                  "bam"
   def reference = fasta && extension=="cram"  ? "--reference ${fasta}" : ""
   if (!fasta && extension=="cram") error "Fasta reference is required for CRAM output"
   """
   INDEX=`find -L ./ -name "*.amb" | sed 's/\\.amb\$//'`

   bwa mem \\
      $args \\
      -t $task.cpus \\
      \$INDEX \\
      $reads \\
      | samtools $samtools_command $args2 ${reference} --threads $task.cpus -o ${prefix}.${extension} -

   cat <<-END_VERSIONS > versions.yml
   "${task.process}":
      bwa: \$(echo \$(bwa 2>&1) | sed 's/^.*Version: //; s/Contact:.*\$//')
      samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
   END_VERSIONS
   """
```

- `def args` - подтягивает дополнительные параметры, которые вставляются в строчку с командой. Указываются в `conf/modules.config`, как `ext.args`. Если процесс multi-tool, то для каждого тула указываются отдельные блоки параметров как `args`, `args2`, `args3`.
- `def prefix` - по умолчанию это `meta.id`, иначе можно указать `ext.prefix` в `conf/modules.config`.
- `def extension` - расширение, используемое для выходного файла.
- далее собирается строка с командой, где каждый параметр разделен \\ для удобства чтения. Добавляются дополнительные аргументы (если есть), указывается количество потоков `$task.cpus` (если возможно), выходные и выходные файлы по необходимости.
- `versions.yml` - формируется файл с версиями всех входящих утилит, библиотек. Версии программ получаются индивидуальными командами и парсятся в единый стиль. 

stub:

```
   stub:
   def args2 = task.ext.args2 ?: ''
   def prefix = task.ext.prefix ?: "${meta.id}"
   def extension = args2.contains("--output-fmt sam")   ? "sam" :
                  args2.contains("--output-fmt cram")  ? "cram":
                  sort_bam && args2.contains("-O cram")? "cram":
                  !sort_bam && args2.contains("-C")    ? "cram":
                  "bam"
   """
   touch ${prefix}.${extension}
   touch ${prefix}.csi
   touch ${prefix}.crai

   cat <<-END_VERSIONS > versions.yml
   "${task.process}":
      bwa: \$(echo \$(bwa 2>&1) | sed 's/^.*Version: //; s/Contact:.*\$//')
      samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
   END_VERSIONS
   """
}
```

- `stub` - используется для сухого запуска с флагом `-stub-run`. При этом блок кода `script` подменяется блоком кода из `stub`, в котором создаются пустые файлы и папки, воспроизводящие реальную структуру выходных файлов. Файл с версиями создается как обычно.


#### 9. Добавление нового модуля

Рассмотрим на примере fastp

1. Устанавливаем модуль

```
nf-core modules install
```

выбираем `fastp`

2. Добавляем include в `workflows/nfcoreintro.nf`

```
include { FASTP                  } from '../modules/nf-core/fastp/main' 
```

3. Добавляем в скрипт наш модуль, формируем входной канал, канал для multiqc и канал версий

```
   //
   // MODULE: Run FastP
   //
   ch_samplesheet = ch_samplesheet.map { meta, reads ->
         [ meta, reads, []]
      }
   FASTP (
      ch_samplesheet,
      false,
      false,
      false
   )
   ch_trimmed_reads = FASTP.out.reads
   ch_multiqc_files = ch_multiqc_files.mix(FASTP.out.json.collect{it[1]})
   ch_versions      = ch_versions.mix(FASTP.out.versions.first())
```

4. Добавляем в `conf/modules.conf` параметры для публикации выходных файлов (опционально)
Для этого модуля мы не будем добавлять, поэтому пример для 

```
   withName: 'MULTIQC' {
      publishDir = [
         path: { "${params.outdir}/multiqc" },
         mode: params.publish_dir_mode,
         saveAs: { filename -> filename.equals('versions.yml') ? null : filename }
      ]
   }
```


5. Добавляем все необходимые параметры для модуля со значениями по умолчанию в nextflow.config (опционально)

6. Добавляем в `conf/modules.conf` доп параметры (опционально)

Для этого модуля мы не будем добавлять, поэтому пример для 
```
   withName: BCFTOOLS_MPILEUP {
      ext.args    = '-Ou'
      ext.args2   = '-m'
   }
```
7. Обновляем nextflow_schema.json
   
```
nf-core schema build
```

8. Обновляем assets/multiqc_config.yml to include any new MultiQC modules (if any exist) and specify order in the report (опционально)

В данном пайплайне мы не будем кастомизировать multiqc


9. Add a citation for the new tool/module to citations.md

10. Update docs/USAGE.md to describe any important information about running of the module (this can be optional in some cases)

11. Update docs/OUTPUT.md to describe the directories output files of the module

12. Update README.md mentioning the tool is used and any pipeline diagrams (optional)
    
13. If not already installed, install prettier (prettier can also be installed using Conda) and then run it formatting on the whole repository

установка
```
mamba install bioconda::prettier 
```

использование

```
prettier -w .
```

14. Run a local test of the pipeline with the included new functionality to check it works.

```
mkdir test/ && cd test/
nextflow run ../main.nf -profile test,<docker,singularity,conda> --outdir ./results <include new parameters required to activate new functionality if necessary>
```

15. Lint the new code with
```
nf-core lint
```

[Подробнее про добавление модуля](https://nf-co.re/docs/tutorials/nf-core_components/adding_modules_to_pipelines)


#### 10. Добавление нового параметра

Рассмотрим добавление нового параметра на примере `fasta` и `bwa_index` .

Используем интеграцию с igenomes, для этого взглянем на `conf/igenomes.config`. Так как тестовые данные у нас про дрожжи, давайте их и будем использовать. Найдем `R64-1-1`

```
params {
   // illumina iGenomes reference file paths
   genomes {
      'GRCh37' {...}
      'R64-1-1' {
         fasta       = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Sequence/WholeGenomeFasta/genome.fa"
         bwa         = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Sequence/BWAIndex/version0.6.0/"
         bowtie2     = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Sequence/Bowtie2Index/"
         star        = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Sequence/STARIndex/"
         bismark     = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Sequence/BismarkIndex/"
         gtf         = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Annotation/Genes/genes.gtf"
         bed12       = "${params.igenomes_base}/Saccharomyces_cerevisiae/Ensembl/R64-1-1/Annotation/Genes/genes.bed"
         mito_name   = "MT"
         macs_gsize  = "1.2e7"
      }
      ...
   }
   ...
}   
```
За bwa index отвечает параметр `fasta` и `bwa`.

Таким образом, params.bwa_index будет содержать полный путь, составленный из ${params.igenomes_base} - прописан в nextflow.config (может изменить, если вы имеете локальную копию или зеркало igenomes) и пути до соответствующего индекса.

1. Добавим их в корневой `main.nf`

```
params.fasta        = getGenomeAttribute('fasta')
params.bwa_index    = getGenomeAttribute('bwa')
```


2. Инициализируем параметры в `/subworkflows/local/utils_nfcore_testtest_pipeline/main.nf`

```
workflow PIPELINE_INITIALISATION {
   take:
   ...
   fasta             // string: Path to reference FASTA file
   bwa_index         // string: Path to BWA index prefix
...
}
```

3.  Cоздаем фактории 
после блока с факторией для samplesheet

```
...
         .set { ch_samplesheet }

   ch_fasta       = channel.value(file(fasta))
                     .map{ file -> [ [], file] }

   ch_bwa_index   = channel.value(file(bwa_index))
                     .map{ file -> [ [], file] }  
```

4. Добавляем выходы

```
   emit:
   samplesheet = ch_samplesheet
   versions    = ch_versions
   fasta       = ch_fasta
   bwa_index   = ch_bwa_index
```

5. Возвращяемся в корневой `main.nf`

Добавляем параметры
```
   GLEBUSSASHA_NFCOREINTRO (
      PIPELINE_INITIALISATION.out.samplesheet,
      PIPELINE_INITIALISATION.out.fasta,
      PIPELINE_INITIALISATION.out.bwa_index,
   )
```

6. Добавляем параметры в `take` и `NFCOREINTRO`

```
workflow GLEBUSSASHA_NFCOREINTRO {

   take:
   samplesheet // channel: samplesheet read in from --input
   fasta       // channel: fasta
   bwa_index   // channel: bwa index

   main:

   //
   // WORKFLOW: Run pipeline
   //
   NFCOREINTRO (
      samplesheet,
      fasta,
      bwa_index
   )
   emit:
   multiqc_report = NFCOREINTRO.out.multiqc_report // channel: /path/to/multiqc_report.html
}
```

7. Добавляем параметры в `workflows/nfcoreintro.nf`

```
workflow NFCOREINTRO {

    take:
    ch_samplesheet // channel: samplesheet read in from --input
    fasta
    bwa_index
...
```

8. Добавляем параметры в 'nextflow_schema.json', для этого используем команду, которая позволяет редактировать это в веб интерфейса или в командной строке.

```
nf-core pipelines schema build
```

Добавим параметры fasta и bwa_index в блок `Reference genome options`

[Что такое igenomes?](https://support.illumina.com/sequencing/sequencing_software/igenome.html)


