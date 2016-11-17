# Phylogenetic toy pipeline 


A proof of concept of a Phylogenetic pipeline intended to show Nextflow scripting and reproducibility capabilities.


[![nextflow](https://img.shields.io/badge/nextflow-%E2%89%A50.20.0-brightgreen.svg)](http://nextflow.io)


## Installation

To run Phytoy-NF you need to install nextflow, by simply checking if you have Java 7+ and if yes, by then typing the following command:

	curl -fsSL get.nextflow.io | bash

If you want to replicate exactly the pipeline and/or not install all the dependencies Phytoy-NF has, then you also need to install Docker and run Phytoy-NF with the '-with-docker' flag, as demonstrated below. Otherwise all the dependencies of Phytoy-NF have to be installed and put in the PATH.

Install Docker on your computer. Read more [here](https://docs.docker.com). 


## Usage

    
You can run Phytoy-NF using the following commands: 

	
	nextflow run phytoy-nf -with-docker [Phytoy-NF command line options]
    


## Command line options:

```
	--in	Path specifying one or more protein sequence datasets in fasta format to be analysed

	--out	Output directory
	
	
	Example: 
	  
	  nextflow run nextflow run phytoy-nf --in '/some/path/*.fasta' --out /my/results			
```




