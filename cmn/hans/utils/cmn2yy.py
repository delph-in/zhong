#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

############################## 
### Chinese POS Tagging: 
###    Penn Chinese Treebank + NLTK + Stanford Chinese POS Tagger
##############################
### [0] if your machine does not have java, install java 
###     (ubuntu) sudo apt-get install default-jre
### [1] install NLTK
### [2] download Stanford POS Tagger
###	http://nlp.stanford.edu/software/stanford-postagger-full-2014-08-27.zip
###     If you use java1.8, you have to download http://nlp.stanford.edu/software/stanford-postagger-full-2014-10-26.zip
### [3] extract the zip file somewhere you want. For me, its path is /home/sanghoun/tools/stanford-postagger/.
### [4] register the path in your bashrc or whatever. The name must be STANFORD_TAGGER_PATH.
###	For example,
###		export STANFORD_TAGGER_PATH=/home/sanghoun/tools/stanford-postagger
### [5] either do [ $ source ~/.bashrc ] or
###	logout and login again.

import sys, os
import nltk
from nltk.tag.stanford import POSTagger

if not os.environ.has_key("STANFORD_TAGGER_PATH"):
	print("STANFORD_TAGGER_PATH is not registered.")
	sys.exit()

tagger = POSTagger(os.environ['STANFORD_TAGGER_PATH']+"/models/chinese-distsim.tagger", os.environ['STANFORD_TAGGER_PATH']+"/stanford-postagger.jar", encoding='utf-8') 

while True:
        try:
            line = sys.stdin.readline()
        except (KeyboardInterrupt, IOError):
            break
        if not line or len(line.strip()) < 1: break

        sentence = line.decode('utf-8')

	output = ""
	#print words.strip().split()
	result = tagger.tag(sentence.split())
	#print result
	_num = _from = _from_c = 0
	for w in result:
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

	print(''.join(output.strip()).encode('utf-8'))
	sys.stdout.flush()

