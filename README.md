# Key Concepts of Nextflow

## Table of Contents
1. [Channels](#1-channels)
   - [Creating Channels](#creating-channels)
   - [Types of Channels](#types-of-channels)
2. [Operators](#2-operators)
   - [Key Operators](#key-operators)
3. [Processes](#3-processes)
   - [Process Structure](#process-structure)
   - [Key Directives](#key-directives)
4. [Factories](#4-factories)
   - [Key Factories](#key-factories)

## 1. Channels
Channels are the foundation of Nextflow. They are used to pass data between processes.

### Creating Channels
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

### Types of Channels
- **Value channel**: contains a single value.
- **Queue channel**: can pass a stream of data.

## 2. Operators
Operators are applied to channels to modify their content.

### Key Operators:
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

## 3. Processes
Processes are the main building blocks of Nextflow. They define computations.

### Process Structure
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

### Key Directives:
- `input:` — process input data.
- `output:` — process output data.
- `script:` — code to execute.

## 4. Factories
Factories help process data streams.

### Key Factories:
- `each` — applies an action to each element.
- `collect` — gathers all elements into a list.
- `flatten` — flattens a list.

```nextflow
ch = Channel.from([1, [2, 3], 4])
ch.flatten() // Result: [1, 2, 3, 4]
```

