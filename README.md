# nextflow-course
Nextflow course

Key Concepts of Nextflow

1. Channels

Channels are the foundation of Nextflow. They are used to pass data between processes.

Creating Channels

Channels are created using functions:

Channel.from(...) — creates a channel from a list of values.

Channel.of(...) — creates a channel from one or more values.

Channel.fromPath(...) — creates a channel from files matching a given path.

// Create a channel from a list of numbers
ch = Channel.from(1, 2, 3, 4, 5)

// Create a channel from files
files = Channel.fromPath("data/*.fastq")

Types of Channels

Value channel: contains a single value.

Queue channel: can pass a stream of data.

2. Operators

Operators are applied to channels to modify their content.

Key Operators:

map — transforms data within a channel.

filter — keeps only elements that satisfy a condition.

combine — merges two channels.

join — joins two channels based on a key.

// Apply map to multiply each element by 2
ch.map { it * 2 }

// Keep only even numbers
ch.filter { it % 2 == 0 }

// Merge two channels
ch1 = Channel.from(1, 2, 3)
ch2 = Channel.from("A", "B", "C")
ch1.combine(ch2)

3. Processes

Processes are the main building blocks of Nextflow. They define computations.

Process Structure

process EXAMPLE {
    input:
    val x  // Accepts variable x
    
    output:
    val result  // Returns result
    
    script:
    result = x * 2
}

Key Directives:

input: — process input data.

output: — process output data.

script: — code to execute.

4. Factories

Factories help process data streams.

Key Factories:

each — applies an action to each element.

collect — gathers all elements into a list.

flatten — flattens a list.

ch = Channel.from([1, [2, 3], 4])
ch.flatten() // Result: [1, 2, 3, 4]

These concepts form the foundation of working with Nextflow. In the next sections, we will explore their practical applications.

