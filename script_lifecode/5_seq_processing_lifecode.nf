#!/usr/bin/env nextflow

// Directory for input data and output results
params.input_file = "../data/test.fasta"
params.output_dir = "./results"

// Python process: Reads all sequences and concatenates them
process process_python {
    conda 'python'
    publishDir params.output_dir, mode: 'copy'

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

// Perl process: Replaces all invalid characters with "N", case-sensitive
process process_perl {
    conda 'perl'
    publishDir params.output_dir, mode: 'copy'

    input:
    path sequence_file

    output:
    path "perl_result.txt"

    script:
    """
    #!/usr/bin/env perl
    open(my \$fh, '<', '${sequence_file}');
    my \$sequence = do { local \$/; <\$fh> };
    
    # Replace all characters not A, T, C, G with N (case-sensitive)
    \$sequence =~ s/[^ATCGatcg]/N/g;
    
    open(my \$out, '>', 'perl_result.txt');
    print \$out \$sequence;
    close(\$out);
    """
}

// Bash process: Converts the entire sequence to uppercase
process process_bash {
    publishDir params.output_dir, mode: 'copy'
    conda 'bash'

    input:
    path sequence_file

    output:
    path "bash_result.txt"

    script:
    """
    sequence=\$(cat ${sequence_file})
    echo "\${sequence^^}" > bash_result.txt
    """
}

// R process: Creates a histogram of nucleotide frequencies
process process_r {
    publishDir params.output_dir, mode: 'copy'
    conda 'r-base'

    input:
    path sequence_file

    output:
    path "*.png"

    script:
    """
    #!/usr/bin/env Rscript

    # Read sequence from file
    sequence <- readLines('${sequence_file}')
    # Count the frequency of each nucleotide
    counts <- table(strsplit(sequence, NULL)[[1]])

    # Plot the nucleotide frequency histogram
    png("nucleotide_frequency_plot.png")
    barplot(counts, main="Nucleotide Frequency", xlab="Nucleotide", ylab="Frequency", col=c("skyblue", "salmon", "lightgreen", "orange"))
    dev.off()
    """
}

// Workflow: Define the execution order of processes
workflow {
    // Input channel for the nucleotide sequence file
    Channel
        .fromPath(params.input_file)
        .set { sequence_file }

    // Sequential execution: Python -> Perl -> Bash -> R
    sequence_file | process_python | process_perl | process_bash | process_r
}
