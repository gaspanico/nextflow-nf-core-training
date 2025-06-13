#!/usr/bin/env nextflow

/*
 * Calculate Seqkit statistics
 */
process SEQKIT_STATS {

    container 'oras://community.wave.seqera.io/library/seqkit:2.10.0--9a5d37887d7c4e09'
    publishDir params.outdir, mode: 'symlink'

    input:
        path input

    output:
        path '*_seqkit-stats.tsv'

    script:
    """
    seqkit stats ${ input } -T > ${ input }_seqkit-stats.tsv
    """
}
