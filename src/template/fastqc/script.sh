#!/bin/bash


## VIASH START
par_input=path/to/file.fastq
par_output=path/to/output/
## VIASH END


mkdir -p "$par_output"

fastqc "$par_input" -o "$par_output"


