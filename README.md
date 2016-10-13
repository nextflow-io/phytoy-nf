
Phylogenetic toy pipeline 
======================

A proof of concept of a Phylogenetic pipeline intended to show Nextflow scripting and reproducibility capabilities.


[![nextflow](https://img.shields.io/badge/nextflow-%E2%89%A50.20.0-brightgreen.svg)](http://nextflow.io)


Installation
-----------

To run phytoy-NF you need to install nextflow, by simply checking if you have Java 7+ and if yes, by then typing the following command:

	curl -fsSL get.nextflow.io | bash

If you want to replicate exactly the pipeline and/or not install all the dependencies shootstrap-NF has, then you also need to install Docker and run phytoy-NF with the '-with-docker' flag, as demonstrated below. Otherwise all the dependencies of phytoy-NF have to be installed and put in the PATH.

Install Docker on your computer. Read more here https://docs.docker.com


Usage
-----------
    
You can run phytoy-NF using the following commands: 

   -> natively:

	nextflow run phytoy [phytoy-nf command line options]
    
   -> with Docker:
	
	nextflow run phytoy -with-docker [phytoy-nf command line options]
    

For example: 

	nextflow run phytoy -with-docker

This command will run (by automatically cloning the respository in your workstation, due to the [Nextflow integration with github](http://www.nextflow.io/docs/latest/sharing.html)) the analysis for the "hip.fa" and "seatoxin.fa" example-datasets contained in the data/ directory, and will generate a multiple sequence alignmnet and a phylogenetic tree for each dataset.


Command line options:
---------------------

	--in_dir	Directory containing one or more protein sequence datasets in fasta format to be analysed

	--out_dir	Output directory


Dependencies:
-------------

phytoy-NF uses the following external programs (which have to exist in the PATH if the pipeline is executed without docker):

	t-coffee	http://www.tcoffee.org/Packages/Stable/Version_11.00.8cbe486/linux/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz
	raxml 		https://github.com/stamatak/standard-RAxML/archive/v8.0.0.zip 


