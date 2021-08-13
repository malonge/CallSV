#!/usr/bin/env bash

# Align call Structural Variants (SVs) given long-read alignments

# positional arguments:
## 1. Reference assembly FASTA file
## 2. Alignment BAM file, coordinate sorted and indexed
## 3. output VCF file prefix

Usage() {
    echo "Usage: $0 ref.fa alns.bam output_prefix"
}

if [ $# -lt 3 ] ; then
    Usage
    exit 1
fi

SNIFFLES=sniffles
IRIS=iris
MM2=minimap2
SAMTOOLS=samtools
RACON=racon

REF=$1
BAM=$2
VCF_PREF=$3

# Call SVs with Sniffles
$SNIFFLES -m $BAM -v $VCF_PREF.raw.vcf -d 50 -n -1 -s 10

# Filter and sort the SV calls
python3 filter.py $VCF_PREF.raw.vcf > $VCF_PREF.f.vcf

# Refine insertion sequences with Iris
$IRIS --keep_long_variants --keep_files minimap_path=$MM2 samtools_path=$SAMTOOLS racon_path=$RACON genome_in=$REF vcf_in=$VCF_PREF.f.vcf reads_in=$BAM vcf_out=$VCF_PREF.i.vcf out_dir=$VCF_PREF.iris_out

# Sort to produce the final VCF
(grep ^"#" $VCF_PREF.i.vcf; grep -v ^"#" $VCF_PREF.i.vcf | sort -k1,1 -k2,2n) > $VCF_PREF.vcf
