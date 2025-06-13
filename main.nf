#!/usr/bin/env nextflow

/*
 * Pipeline parameters
 */
params.indir   = "${projectDir}/data/"
params.outdir  = "results"
params.outfile = "seqkit_stats_output.txt"

/*
 * Calculate Seqkit statistics
 */
process SEQKIT_STATS {

    container 'oras://community.wave.seqera.io/library/seqkit:2.10.0--9a5d37887d7c4e09'
    publishDir params.outdir, mode: 'symlink'

    input:
        path input

    output:
        path params.outfile

    script:
    """
    seqkit stats $input > $params.outfile
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
