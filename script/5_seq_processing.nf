#!/usr/bin/env nextflow

// Директория для входных данных и сохранения выходных данных
params.input_file = "../data/test.fasta"
params.output_dir = "./results"

// Процесс на Python: Считывает все последовательности и склеивает их
process process_python {
    publishDir params.output_dir, mode: 'copy'
    conda 'python'

    input:
    path sequence_file

    output:
    path "python_result.txt"

    script:
    """
    #!/usr/bin/env python3

    with open('${sequence_file}', 'r') as f:
        sequences = [line.strip() for line in f if not line.startswith('>')]

    concatenated_sequence = ''.join(sequences)

    with open('python_result.txt', 'w') as f:
        f.write(concatenated_sequence)
    """
}

// Процесс на Perl: Заменяет все некорректные символы на "N", учитывая регистр
process process_perl {
    publishDir params.output_dir, mode: 'copy'
    conda 'perl'

    input:
    path sequence_file

    output:
    path "perl_result.txt"

    script:
    """
    #!/usr/bin/env perl
    open(my \$fh, '<', '${sequence_file}');
    my \$sequence = do { local \$/; <\$fh> };
    
    # Заменяем все символы, не являющиеся A, T, C, G на N (с учетом регистра)
    \$sequence =~ s/[^ATCGatcg]/N/g;
    
    open(my \$out, '>', 'perl_result.txt');
    print \$out \$sequence;
    close(\$out);
    """
}

// Процесс на Bash: Преобразует всю последовательность в верхний регистр
process process_bash {
    publishDir params.output_dir, mode: 'copy'

    input:
    path sequence_file

    output:
    path "bash_result.txt"

    script:
    """
    #!/bin/bash
    sequence=\$(cat ${sequence_file})
    echo "\${sequence^^}" > bash_result.txt
    """
}

// Процесс на R: Строит гистограмму частот нуклеотидов
process process_r {
    publishDir params.output_dir, mode: 'copy'
    conda 'r-base'

    input:
    path sequence_file

    output:
    path "nucleotide_frequency_plot.png"

    script:
    """
    #!/usr/bin/env Rscript

    # Читаем последовательность из файла
    sequence <- readLines('${sequence_file}')
    # Подсчет частот каждого нуклеотида
    counts <- table(strsplit(sequence, NULL)[[1]])

    # Построение гистограммы частот
    png("nucleotide_frequency_plot.png")
    barplot(counts, main="Nucleotide Frequency", xlab="Nucleotide", ylab="Frequency", col=c("skyblue", "salmon", "lightgreen", "orange"))
    dev.off()
    """
}

// Workflow: Определяем порядок выполнения процессов
workflow {
    // Входной канал для файла с нуклеотидной последовательностью
    Channel
        .fromPath(params.input_file)
        .set { sequence_file }

    // Запуск процессов последовательно: Python -> Perl -> Bash -> R
    sequence_file | process_python | process_perl | process_bash | process_r
}
