#!/usr/bin/env python

import sys

# First arg is vcf file

rat_cut = 0.3

with open(sys.argv[1], "r") as f:
    for line in f:
        line = line.rstrip()
        if line.startswith("#"):
            print(line)
        else:
            fields = line.split("\t")
            tags = fields[7].split(";")

            # Get supporting read info
            gt, rs, vs = fields[9].split(":")
            if gt == "0/0" or gt == "./.":
                continue

            rs, vs = int(rs), int(vs)
            
            rat = (vs/(rs+vs))
            if rat >= rat_cut:
                print(line)
