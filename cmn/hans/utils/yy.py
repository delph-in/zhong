#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

############################## 
### Converting Chinese sentences into YY mode inputs 
### using 
###    Penn Chinese Treebank TagSet
###    Stanford Word Segmenter
###    Stanford Chinese POS Tagger
###    NLTK 
##############################
### Created by Sanghoun Song (sanghoun@ntu.edu.sg)
###            2014-11-25
##############################
### USAGE:
###    ./hans-yy.py PATH-OF-STANFORD_SEGMENTER PATH-OF-STANFORD_POSTAGGER 

import sys, codecs
from nltk.tokenize.stanford_segmenter import StanfordSegmenter
from nltk.tag.stanford import POSTagger

seg_path = '/home/sanghoun/tools/stanford-segmenter'
tagger_path = '/home/sanghoun/tools/stanford-postagger'

if len(sys.argv) > 2: tagger_path = sys.argv[2]
if len(sys.argv) > 1: seg_path = sys.argv[1]

segmenter = StanfordSegmenter(path_to_jar=seg_path+"/stanford-segmenter-3.4.1.jar", path_to_sihan_corpora_dict=seg_path+"/data", path_to_model=seg_path+"/data/ctb.gz", path_to_dict=seg_path+"/data/dict-chris6.ser.gz")
tagger = POSTagger(tagger_path+"/models/chinese-distsim.tagger", tagger_path+"/stanford-postagger.jar", encoding='utf-8') 
sentences = codecs.getreader("utf-8")(sys.stdin).readlines()

output = ""

for sentence in sentences:
	_num = _from = _from_c = 0
	for w in tagger.tag(segmenter.segment(sentence.strip()).split()):
		[orth, tag] = w[1].split('#')
		_num += 1
		output += '('
		output += str(_num)
		output += ', '
		output += str(_from)
		output += ', '
		output += str(_from+1)
		output += ', <'
		output += str(_from_c)
		output += ':'
		output += str(len(orth))
		output += '>, 1, "'
		output += orth
		output += '", 0, "null", "'
		output += tag
		output += '" 1.0000) '
		_from += 1
		_from_c += len(orth)

ftmp = open("tmp.yy", 'w')
ftmp.write(output.strip().encode('UTF-8'))
ftmp.close()


