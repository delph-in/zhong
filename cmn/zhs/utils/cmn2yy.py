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
###        http://nlp.stanford.edu/software/stanford-postagger-full-2014-08-27.zip
###     If you use java1.8, you have to download http://nlp.stanford.edu/software/stanford-postagger-full-2014-10-26.zip
### [3] extract the zip file somewhere you want. For me, its path is /home/sanghoun/tools/stanford-postagger/.
### [4] register the path in your bashrc or whatever. The name must be STANFORD_TAGGER_PATH.
###        For example,
###                export STANFORD_TAGGER_PATH=/home/sanghoun/tools/stanford-postagger
### [5] either do [ $ source ~/.bashrc ] or
###        logout and login again.

import sys, os
import nltk
from nltk.tag.stanford import StanfordPOSTagger

if "STANFORD_TAGGER_PATH" not in os.environ :
        print("STANFORD_TAGGER_PATH is not registered.")
        sys.exit()

tagger = StanfordPOSTagger(os.environ['STANFORD_TAGGER_PATH']+"/models/chinese-distsim.tagger", os.environ['STANFORD_TAGGER_PATH']+"/stanford-postagger.jar", encoding='utf-8') 

while True:
        try:
            line = sys.stdin.readline()
        except (KeyboardInterrupt, IOError):
            break
        if not line or len(line.strip()) < 1: break

        sentence = line

        output = ""
        #print words.strip().split()
        words = sentence.split()

        #This is a tentative solution for handling too long sentences.
        #FIX ME!
        if len(words) > 200: 
                print('(0, 0, 1, <0:18>, 1, "TOO-LONG-SENTENCE", 0, "null", "X" 1.0000)')
                sys.stdout.flush()
                continue

        result = tagger.tag(words)
        #print result
        _num = _from = _from_c = 0
        for w in result:
                [orth, tag] = w[1].split('#')

                #This is also a tentative solution. FIX ME!
                if orth == '"': orth = '”'

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

        print(''.join(output.strip()))
        sys.stdout.flush()

