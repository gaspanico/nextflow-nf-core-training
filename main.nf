#!/usr/bin/env nextflow

/*
 * Pipeline parameters
 */

// Primary input
params.reads_fastq = "${projectDir}/data/reads_NA12878_R1.fastq"
params.outdir    = "results"

/*
 * Calculate Seqkit statistics
 */
process SEQKIT_STATS {

    container 'oras://community.wave.seqera.io/library/seqkit:2.10.0--9a5d37887d7c4e09'

    publishDir params.outdir, mode: 'symlink'

    input:
        path input_fastq

    output:
        path 'seqkit_stats_output.txt'

    script:
    """
    seqkit stats '$input_fastq' > seqkit_stats_output.txt
    """
}

workflow {

    // Create input channel (single file via CLI parameter)
    fastq_ch = Channel.fromPath(params.reads_fastq)

    // Calculate Seqkit statistics
    SEQKIT_STATS(fastq_ch)
}
