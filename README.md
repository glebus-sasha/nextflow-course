# Key Concepts of Nextflow

<!-- TOC -->
<!-- /TOC -->

## Table of Contents
- [Key Concepts of Nextflow](#key-concepts-of-nextflow)
  - [Table of Contents](#table-of-contents)
  - [1. Part one](#1-part-one)
    - [1. Channels](#1-channels)
      - [Creating Channels](#creating-channels)
      - [Types of Channels](#types-of-channels)
    - [2. Operators](#2-operators)
      - [Key Operators:](#key-operators)
    - [3. Processes](#3-processes)
      - [Process Structure](#process-structure)
      - [Key Directives:](#key-directives)
    - [4. Factories](#4-factories)
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

## 1. Part one

### 1. Channels
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

### 2. Operators
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

### 3. Processes
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

### 4. Factories
Factories help process data streams.

#### Key Factories:
- `each` — applies an action to each element.
- `collect` — gathers all elements into a list.
- `flatten` — flattens a list.

```nextflow
ch = Channel.from([1, [2, 3], 4])
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
├── main.nf                  # The main entrypoint for the pipeline, defining workflow logic.
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
    └── test.nf              # A workflow used for testing subcomponents or modules.
```

[Подробнее](https://nf-co.re/docs/contributing/pipelines/pipeline_file_structure)

#### 2. Структура папки modules (пример)

```
modules                          # Collection of nf-core/modules used by the pipeline.
├── local                        # Modules written specifically for this pipeline.
│   ├── bracken_results          # Module for handling Bracken results.
│   │   └── main.nf              # Main workflow logic for the bracken_results module.
└── nf-core                      # Namespaced directory containing imported nf-core modules.
    ├── bracken                  # nf-core Bracken module.
    │   └── bracken              # Subdirectory containing Bracken workflow files.
    │       ├── environment.yml  # Conda environment specification for Bracken module.
    │       ├── main.nf          # Main workflow logic for Bracken module.
    │       ├── meta.yml         # Metadata describing Bracken module parameters and inputs.
    │       └── tests            # Test definitions for Bracken module.
    │           └── ...          # Test files and snapshots.
    ├── cat                      # nf-core Cat module.
    │   └── fastq                # Subdirectory containing Cat fastq workflow files.
    │       ├── environment.yml  # Conda environment specification for Cat fastq module.
    │       ├── main.nf          # Main workflow logic for Cat fastq module.
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
}```

- `stub` - используется для сухого запуска с флагом `-stub-run`. При этом блок кода `script` подменяется блоком кода из `stub`, в котором создаются пустые файлы и папки, воспроизводящие реальную структуру выходных файлов. Файл с версиями создается как обычно.