# nextflow-course
Nextflow course

## 1. Сравнение workflow systems

Benefits of using Nextflow or Snakemake
You can easily turn a wide variety of code into a more robust pipeline. That includes Python, R, and shell scripts – or even Jupyter notebooks.
Support for reproducible environments through containerization (e.g. using Docker images) or Conda.
Retrying failed pipelines is faster with built-in caching of succeeded steps.
They provide guardrails for good pipelining practices.
Both are open-source with active communities, and have free basic options.
Limitations of using Nextflow and Snakemake
Both have built-in support for offloading tasks to the cloud, but the robustness is dependent on your scale and deployment mechanism.
Template pipelines, like Nextflow's nf-core or Snakemake Workflows, aren't plug-and-play; they still require a deep understanding of the pipeline and the unique needs of your analysis.
Those trained as software engineers usally find both Nextflow and Snakemake more frustrating than traditional workflow managers like Airflow, Luigi, or Prefect.
Both stem from an academic background, which led to some design decisions that are suboptimal for use in industry.
Built-in observability and developer tooling leaves room for improvement.

Nextflow:​

Dealbreakers, slowdowns, and unique benefits

Nextflow has a popular set of template pipelines (nf-core) and a larger number of employees working on maintaining their core – but it's a polarizing workflow language.
Common dealbreakers
It's built with Groovy, a dialect of Java, which has a steep learning curve and complex syntax. It's rare to see Groovy used anywhere else in this industry, so the learning the language isn't a transferable skill.
Slowdowns
How Nextflow defines pipeline I/O – channels – seems to have a steeper learning curve than Snakemake.
While there are many integrations, most are buggy.
There's a lot of boilerplate.
Unique benefits of Nextflow
How Nextflow defines pipeline I/O – channels – supports more than just files as the output of a step, and pipelines can be dynamically re-ordered.
It's easier to get commercial support. That's probably because they're a venture-funded company that values revenue, while Snakemake is maintained by an academic lab.
nf-core pipelines have better documentation.
Fully-managed cloud support is native to Nextflow Tower (with many features behind a paywall).
Quirks
It creates many temporary work directories with an unintuitive set of symlinks and temporary files.
The venture-funded company that runs Nextflow self-promotes heavily (e.g. on Reddit and Wikipedia), which is uncommon in the bioinformatics community.

Snakemake:​
Dealbreakers, slowdowns, and unique benefits
Snakemake is the spiritual child of Python and GNU make (hence the name "snakemake"). It works well with vanilla Python, and pipelines are defined in a way similar to GNU make's makefiles.
Common dealbreakers
The structure of the pipeline is based on output files for each step, which is clunky for steps which don't produce files.
Built-in execution support is more polished for cluster execution than cloud execution. There's no native support for running pipelines in a managed service in the cloud (which we patch with FlowDeploy).
No enterprise support.
An aside: cloud and cluster support with Snakemake​
A few years ago, cloud and cluster support was much better in Nextflow, and many chose Nextflow over Snakemake solely for that reason. The ecosystem around Snakemake has caught up since then, and it's no longer a clear dealbreaker.
Slowdowns
Documentation lacks short and straightforward examples.
Unique benefits of Snakemake
It's Python! You can use Snakemake directly in Python or through the command-line.
Using output files to define a pipeline's structure is easier to understand for some.
The dry run feature helps test pipelines, which is possible due to how Snakemake structures pipelines. To do the same in Nextflow is an experimental feature that requires separate manual "stubbing" of pipeline steps.
Quirks
It's maintained by an academic group.

## 2. requirments
- git
- nextflow
- singularity

## 3. installation

```
java -version
curl -s https://get.nextflow.io | bash
chmod +x nextflow
mkdir -p $HOME/.local/bin/
mv nextflow $HOME/.local/bin/
```

## 4. nextflow
Nextflow основан на языке Groovy, который, в свою очередь, является расширением Java.

Создадим свой hello world и попутно посмотрим на особенности языка Groovy

```
git clone https://github.com/glebus-sasha/nextflow-course.git
cd nextflow-course/scripts
nano 1.hello_world.nf
nextflow run 1.hello_world.nf
# println 'Hello world!' // line comment
# /*
# * block comment
# */
# println 'Hello again!'
```

Мы можем использовать shebang
```
#!/usr/bin/env nextflow
```
Добавим ее в 1.hello_world.nf

```
chmod +x 1.hello_world.nf
./1.hello_world.nf 
```

Обратим внимание на структуру 
```
ls -lha
```

Рассмотрим условные выражения 2.conditional_expressions.nf
```
def x = Math.random()
if( x < 0.5 ) {
    println 'You lost.'
}
else {
    println 'You won!'
}
```

Можно создавать функции 3.functions.nf
```
def add(a, b) {
    return a + b
}

println(add(2, 3))
```

Более подробно
https://www.nextflow.io/docs/latest/reference/syntax.html

## 5. first workflow

```
params.str = 'Hello world!'

process splitLetters {
    output:
    path 'chunk_*'

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}

process convertToUpper {
    input:
    path x

    output:
    stdout

    """
    cat $x | tr '[a-z]' '[A-Z]'
    """
}

workflow {
    splitLetters | flatten | convertToUpper | view { v -> v.trim() }
}
```

Снова взглянем на структуру папки work

```
tree work
```

## 6. work_with_files

Но в реальности вам нужно работать с входными файлами, чтобы получать выходные файлы.
Создадим workflow для работы с файлами, попутно разбирая концепцию каналов
