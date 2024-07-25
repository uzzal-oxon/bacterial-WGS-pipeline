# Bacterial-WGS-pipeline:An automation for the high quality bacterial genome and its annotation 

This repository contains a comprehensive command-line pipeline for bacterial whole-genome sequencing (WGS) analysis, from quality control to genome annotation. The pipeline leverages FastQC, Trimmomatic, Unicycler, Prokka, and QUAST for a seamless workflow.
## Pipeline Overview

1. **Quality Control (QC):**
   - FastQC: Assesses raw read quality.
   - Trimmomatic: Removes low-quality bases and adapter sequences.

2. **Hybrid Assembly:**
   - Unicycler: Performs de novo assembly for accurate contig generation.

3. **Genome Annotation:**
   - Prokka: Identifies and annotates genomic features (genes, coding sequences, etc.).

4. **Assembly Evaluation (Optional):**
   - QUAST: Evaluates assembly quality and generates reports.

## Usage

1. **Clone Repository:**
   ```bash
   git clone [repository URL]
   cd [repository name]
   
## Data Preparation:

Place your raw FASTQ files (e.g., SRR1234567_1.fastq.gz, SRR1234567_2.fastq.gz) in the sra/ directory.
(Optional) If using QUAST, ensure the quast.py script is accessible.
Execute Pipeline:
>**bash (your_pipeline_name).sh>
Follow the prompts to install missing tools or skip if already present.
Provide the accession number of your FASTQ files (e.g., SRR1234567) when prompted.

## Output
The pipeline will generate the following directories:

1. fastqc_result/: FastQC reports for raw and trimmed reads.
2. trimmomatic/: Trimmed FASTQ files.
3. assembly_output/: Unicycler assembly results (including assembly.fasta).
4. annotated_genome/: Prokka annotation output files (GBK, FAA, etc.).
5. quast_evaluation_result/: QUAST evaluation reports (if QUAST is run).
6. NCBI_submission_materials/: Key files prepared for NCBI submission.

## Dependencies

Bioinformatics Tools:
1. FastQC (v0.11.9 or later)
2. Trimmomatic (v0.39 or later)
3. Unicycler (v0.4.8 or later)
4. Prokka (v1.14.6 or later)
5. QUAST (v5.0.2 or later, optional)
Conda: For managing package environments.

<pre>
* <a href="https://anaconda.org/bioconda/fastqc">FastQC</a>
* <a href="https://anaconda.org/bioconda/trimmomatic">Trimmomatic</a>
* <a href="https://anaconda.org/bioconda/unicycler">Unicycler</a>
* <a href="https://anaconda.org/bioconda/prokka">Prokka</a>
* <a href="https://anaconda.org/bioconda/quast">QUAST</a>
</pre>

## Important Considerations
Computational Resources: This pipeline is designed for high-performance computing (HPC) environments due to the computational demands of assembly and annotation.
Reference Genome: For accurate annotation with Prokka, consider using a closely related reference genome if available.
NCBI Submission: The NCBI_submission_materials/ directory contains files suitable for submission to NCBI's GenBank. Be sure to review and adjust metadata as needed before submission.

## License
© [2024] Mohammad Uzzal Hossain, University of Oxford. All rights reserved.

## Citation
If you use this pipeline in your research, please cite the relevant tools used in this pipeline.

## Contact
For questions or issues, please contact Mohammad Uzzal Hossain, E-mail: uzzalbge10044@gmail.com

**Key Improvements:**

- **Clear Structure:** The README is organized into logical sections for easy navigation.
- **Detailed Instructions:** Steps are explained thoroughly, even guiding users on tool installation.
- **Comprehensive Output Description:** Users know what to expect and where to find results.
- **Professional Tone:**  The language is precise and suitable for scientific communication.
- **Best Practices:** Includes recommendations for HPC usage, reference genomes, and submission.

