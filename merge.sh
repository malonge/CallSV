#!/usr/bin/env bash

# Merge SV VCF files

# positional arguments:
## 1. File of VCF File Names (fofn)

Usage() {
    echo "Usage: $0 vcf.fofn"
}

if [ $# -lt 1 ] ; then
    Usage
    exit 1
fi

JASMINE=jasmine

$JASMINE file_list=$1 out_file=merged.vcf max_dist=500 spec_reads=3 --output_genotypes
