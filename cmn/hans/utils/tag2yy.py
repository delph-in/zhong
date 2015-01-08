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

import sys, codecs
sentences = codecs.getreader("utf-8")(sys.stdin).readlines()
output = ""
for sentence in sentences:
	_num = _from = _from_c = 0
	for w in sentence.strip().split():
		[orth, tag] = w.split('#')
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
	output = output.strip() + "\n"
print(''.join(output.strip()).encode('utf-8'))

