#!/bin/bash

## VIASH START
par_input=/home/marta_fogt/custom_pipeline/OSC_pipeline_vsh/resources_test/
par_hostDB=/mnt/mnt/microbiome/references/if_pan_references/kneaddata_mouse/
par_output=output/
## VIASH END

mkdir -p "$par_output"


files_R1_list=(`ls $par_input/*1.f*q.gz`)
files_R2_list=(`ls $par_input/*2.f*q.gz`) 


# Get the length of each list
len_R1=${#files_R1_list[@]}
len_R2=${#files_R2_list[@]}



# Extract names of samples
# Array to hold sample names
sample_names=()

# Extract sample names from file paths
for path in "${files_R1_list[@]}"; do
    sample_name=$(basename "$path" | sed 's/\_R[12]\.f[a-z]*q\.gz//')
    sample_names+=("$sample_name")
done

# Print sample names
echo "Sample names:"
for name in "${sample_names[@]}"; do
    echo "$name"
done


if [[ $len_R1 -eq $len_R2 ]]; then
	echo "Paired-end"
    for sample in "${sample_names[@]}"; do
        echo "${sample}_R1.fastq.gz"
        kneaddata \
        -i1 "$par_input/${sample}_R1.fastq.gz" \
        -i2 "$par_input/${sample}_R2.fastq.gz" \
        -p 18 \
        -t 18 \
        --max-memory 48g \
        -db "$par_hostDB/mouse" \
        --cat-final-output \
        --bypass-trf \
        --sequencer-source none \
        --run-fastqc-start \
        -o "$par_output"
    done
fi








