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
 */


params.in = "$baseDir/data/*"
params.out = 'results'


Channel
	.fromPath(params.in)
	.ifEmpty { error "Cannot find any data -- Check the path specified: `${params.in}`" }
        .set { file_names }



process align{
  publishDir params.out

  input:
      file(seq_file) from file_names
  output:
      file "${seq_file}.aln" into msas 
  
  """
      t_coffee -in $seq_file -outfile ${seq_file}.aln
  """
}


process align_msas{
  publishDir params.out

  input:
      file 'seq*.fa' from msas.toList()
  output:
      file res_aln into big_msa

  """
      t_coffee -profile seq*.fa -outfile res_aln -output phy
  """
}

process get_raxml_tree{
  publishDir params.out

  input:
      file(msa_file) from big_msa
  output:
      file "RAxML_bestTree.*" into trees
  
  """
      raxmlHPC -f d -j -p 9 -m PROTGAMMALG -s $msa_file -n ${msa_file} 
  """
}
