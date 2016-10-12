#!/usr/bin/env nextflow
/*
 * Copyright (c) 2016, Centre for Genomic Regulation (CRG) and the authors.
 *
 *   This file is part of 'phylotoy-NF'.
 *
 *   phylotoy-NF is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   phylotoy-NF is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with phylotoy-NF.  If not, see <http://www.gnu.org/licenses/>.
 */

/* 
 * Main phylotoy-NF script
 *
 * @authors
 * Maria Chatzou <mxatzou@gmail.com>
 */


params.file_names="$baseDir/data/prestin_SLC26A5.35eutheria.original.msa"
params.out_dir="."

params.rand_value=9
params.tag_name="PRESTIN"

file_names=Channel.fromPath(params.file_names)

process align{
  publishDir params.out_dir, mode: "copy"

  input:
      set file(seq_file) from file_names
  output:
      file(seq_file.aln) into msas 
  
  """
      clustalo -i $seq_file -o $seq_file.aln
  """
}

process get_raxml_tree{
  publishDir params.out_dir, mode: "copy"

  input:
      set file(msa_file) from msas
  output:
      file "RAxML_bestTree*" into trees
  
  """
      raxmlHPC -T 2 -f d -j -p $params.rand_value -m PROTGAMMALG -s $msa_file -n $params.tag_name 
  """
}

