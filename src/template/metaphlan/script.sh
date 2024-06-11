#!/bin/bash


## VIASH START
par_input=path/to/file.fastq
#par_index_bowtie=path/to/bowtie/index/name
par_bowtieDB=path/to/bowtie/db
par_output=path/to/output/
## VIASH END


mkdir -p "$par_output"

metaphlan "$par_input" --index mpa_vJan21_CHOCOPhlAnSGB_202103 --bowtie2db "$par_bowtieDB" --nproc 18 --input_type fastq -o "$par_output"

