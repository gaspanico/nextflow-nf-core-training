#!/usr/bin/env nextflow

include { SEQKIT_STATS } from './modules/seqkit/stats/main.nf'

workflow {

    // Create input channel (single file via CLI parameter)
    inputs_ch = Channel.fromPath(params.indir + '/*')
                       .filter(~/.*\.(fa|fq|fastq|fq\.gz|fastq\.gz)$/)
                       .collect()

    // Calculate Seqkit statistics
    SEQKIT_STATS(inputs_ch)
}
