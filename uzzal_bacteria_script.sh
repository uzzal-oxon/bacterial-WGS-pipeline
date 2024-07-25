#!/bin/bash
echo " Bacterial Genome Assembly and Annotation "
eval "$(conda shell.bash hook)"
## Quality Control
echo "** Quality Control Check **"
echo "Do you want to install fastqc (y/n)??"
read choice1

if [[ "$choice1" =~ [yY] ]]; then  
    sudo apt install fastqc
elif [[ "$choice1" =~ [nN] ]]; then  
    echo "Skipping fastqc installation"
else
    echo "Invalid input. Please enter 'y' or 'n'."  # Added else clause
fi

mkdir fastqc_result
echo "Carefully provide the accession number of your fastq file within the 'sra' directory [e.g. SRR1234567]"
read fastq
fastqc -o fastqc_result -t 2 ./sra/"$fastq"*.fastq

echo "* Trimming the fastq files: ***"

echo "Do you want to install trimmomatic (y/n) ??"
read trimmomatic
if [[ "$trimmomatic" =~ [yY] ]]; then  
    sudo apt install trimmomatic
elif [[ "$trimmomatic" =~ [nN] ]]; then  
    echo "Skipping trimmomatic installation"
else
    echo "Invalid input. Please enter 'y' or 'n'."  # Added else clause
fi

mkdir trimmomatic

TrimmomaticPE -phred33 ./sra/"$fastq"_1.fastq ./sra/"$fastq"_2.fastq -baseout trimmomatic/trimmed_"$fastq".fastq LEADING:15 TRAILING:15 SLIDINGWINDOW:4:25 MINLEN:36
echo "Trimming completes succesfully"

echo "# Hybrid Assembly"

mkdir assembly_output
# De Novo Assembly using unicycler
echo "** assembly using unicycler **"
# Activate the 'unicycler' conda environment
source activate unicycler
unicycler -1 ./trimmomatic/trimmed_"$fastq"_1P.fastq -2 ./trimmomatic/trimmed_"$fastq"_2P.fastq -o assembly_output -t 190

cp ./assembly_output/assembly.fasta ./
# Deactivate the conda environment
conda deactivate 

## Genome annotation
echo "** Genome Annotation **"

# Activate the 'prokka' conda environment
source activate prokka

# Perform genome annotation using Prokka
echo "** Running Prokka annotation (please wait...) **"
prokka --kingdom bacteria --cpus 190 --prefix annotated_genome --locustag annotated_genome assembly.fasta

rm ./assembly.fasta
# Deactivate the conda environment
conda deactivate  

echo "** Analysis Complete **"

echo "Thank you!"

# ------------------------------------------------------------------------ #
#                      Added QUAST and File Copying                       #
# ------------------------------------------------------------------------ #

# Run QUAST for assembly evaluation
quast.py ./assembly_output/assembly.fasta -o quast_evaluation_result

# Create directory for NCBI submission materials
mkdir NCBI_submission_materials

# Copy relevant files to the NCBI submission directory
cp ./assembly_output/assembly.fasta ./NCBI_submission_materials
cp -r ./annotated_genome/annotated_genome.faa ./annotated_genome/annotated_genome.gbk ./annotated_genome/annotated_genome.sqn ./annotated_genome/annotated_genome.txt ./NCBI_submission_materials  
cp -r ./quast_evaluation_result/icarus_viewers ./quast_evaluation_result/report.html ./quast_evaluation_result/report.pdf ./NCBI_submission_materials

echo "Thank you!"





