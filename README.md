# nextflow-course
Nextflow course

## 2. Сравнение workflow systems
Давайте сравним workflow systems

## 3.
Главное преимущество таких систем - это автоматизация и воспроизводииость.
Это может быть удобно как для разового исследования, так и для программного обеспечения для обработки каких либо данных.
Вы можете подробнее прочитать по ссылке.
Если сравнивать наиболее популярные, но не единственные системы, такие как snakemake и nextflow, которые были разработаны для биоинформатиков, то snakemake более ламповый, простой, а nextflow более серьезный и мощный.
Snakemake написан на питоне, в то время как nextflow - основан на groovy. Ксати, что касается groovy, поспешу успокоить - нет ни каких проблем с groovy, если вы его знаете. Да и если не знаете - то тоже никаких проблем, он вам пригодится совсем немного, разве что для кастомизации. А какие то необходимые основы мы сегодня рассмотрим.

## 4.
В то время как snakemake что то так начинает поддерживать, nextflow как правило из коробки интегрирован с большинством современных систем.

## 5. requirments
- git
- nextflow
- singularity
## 7. 
Нам сегодня понадобится nextflow, git, apptainer, conda.
Если у вас что то из этого не установлено, то вы можете попытаться установить сейчас, если будут какие то вопросы - спрашивайте
Если у вас отсутствует конда - то вы можете просто через apt установить, то, что нам сегодня будет не хватать.
Что касается систем контейнеризации - то вместо apptainer вы можете использовать тот же докер или сингулярити - без проблем. Но мы будем рассматривать на примере apptainer

## 8

## 9 installation

## 10
nextflow в свою очерез требует java, потому что groovy - это синтактический сахар над java

```
java -version
curl -s https://get.nextflow.io | bash
chmod +x nextflow
mkdir -p $HOME/.local/bin/
mv nextflow $HOME/.local/bin/
```
## 11 Nextflow programming language

## 12
Для тех кто не знает java может быть не сильно важно, но groovy отличается от java более простым синтаксисом, он поддерживает динамическую типизацию. Но мы на этом сильно останавливаться не будем. 

## 13
Пришло время перейти в терминал.
Вы можете работать в 3 режимах - в режими кино, вы уставшие смотрите меня, для этого налейте себе вкусного чаю или что вы там пьете.
Другая крайность - это в режиме lifecode вы пишите всё вместе со мной, если что то не получается - спрашивайте, пойдем быстро, но будет полезно.
Есть компромисный вариант - вы запускаете уже готовые файлы.



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
Создадим workflow для работы с файлами, попутно разбирая концепцию каналов.
Так же продемонстрируем, что можно использовать разные языки в процессах
