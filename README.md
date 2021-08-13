# CallSV

This repo provides a simple pipeline for calling Structural Variants (SVs) from long-read alignments. 

## Dependencies

- [Sniffles](https://github.com/fritzsedlazeck/Sniffles)
- [Iris](https://bioconda.github.io/recipes/irissv/README.html)
- [Minimap2](https://github.com/lh3/minimap2)
- [Samtools](https://github.com/samtools/samtools)
- [Racon](https://github.com/lbcb-sci/racon)
- [Jasmine](https://github.com/mkirsche/Jasmine)

## Installation

If executables for the above dependencies are not in one's PATH, they can be manually added to the bash scripts.

## Run

For each sample, call SVs by running `./call_hifi.sh` for PacBio HiFi read alignments or `./call_ont.sh` for Oxford Nanopore read alignments.

To merge SV calls across samples, use `./merge.sh`
