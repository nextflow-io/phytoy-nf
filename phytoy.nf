#!/usr/bin/env nextflow
/*
 * Copyright (c) 2016, Centre for Genomic Regulation (CRG) and the authors.
 *
 *   This file is part of 'phytoy-NF'.
 *
 *   phylotoy-NF is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   phytoy-NF is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with phytoy-NF.  If not, see <http://www.gnu.org/licenses/>.
 */

/* 
 * Main phytoy-NF script
 *
 * @authors
 * Maria Chatzou <mxatzou@gmail.com>
 * Paolo Di Tommaso <paolo.ditommaso@gmail.com>
 */


params.in = "$baseDir/data/*.tfa"
params.out = 'results'


Channel
    .fromPath(params.in)
    .ifEmpty { error "Cannot find any data -- Check the path specified: `${params.in}`" }
    .set { seq_files }



process align {

  input:
      file(seq) from seq_files
  output:
      file("*.phy") into msa_files 
  
  """
      clustalw -infile=$seq -output=phylip -outfile=${seq.baseName}.phy
  """
}



process get_raxml_tree{
  publishDir params.out, mode: 'copy'
  cpus 2 
  
  input:
      file(msa) from msa_files
  output:
      file "RAxML_bestTree.*" into trees
  
  """
      raxmlHPC -f d -j -p 9 -T ${task.cpus} -m PROTGAMMALG -s $msa -n ${msa.baseName} 
  """
}

workflow.onComplete {
  println workflow.success ? "Output files are saved in the folder `$params.out`" : 'Oops .. something went wrong.' 
}