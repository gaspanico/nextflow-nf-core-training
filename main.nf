#!/usr/bin/env nextflow

/*
 * Pipeline parameters
 */

// Primary input
params.indir  = "${projectDir}/data/"
params.outdir = "results"

/*
 * Calculate Seqkit statistics
 */
process SEQKIT_STATS {

    container 'oras://community.wave.seqera.io/library/seqkit:2.10.0--9a5d37887d7c4e09'

    publishDir params.outdir, mode: 'symlink'

    input:
        path input

    output:
        path 'seqkit_stats_output.txt'

    script:
    """
    seqkit stats $input > seqkit_stats_output.txt
    """
}

workflow {

    // Create input channel (single file via CLI parameter)
    inputs_ch = Channel.fromPath(params.indir + '/*')
                       .filter(~/.*\.(fa|fq|fastq|fq\.gz|fastq\.gz)$/)
                       .collect()

    // Calculate Seqkit statistics
    SEQKIT_STATS(inputs_ch)
}
