# make_testsuite.py GLOSS_FILENAME (PHENOMENA) < INPUT_FILENAME > OUTPUT_FILENAME

import sys

pronunciation = {}
gloss = {}

myfile = open(sys.argv[1])
lines = myfile.readlines()
myfile.close()
for line in lines:
	each = line.strip().split()
	if len(each) == 3: 
		pronunciation[each[0]] = each[1]
		gloss[each[0]] = each[2]

phenomena = ""
if len(sys.argv) > 2: phenomena = sys.argv[2]

print """Language: LANGUAGE_NAME
Language code: ISO
Lines: orth translit gloss translat
Author: YOUR_NAME
Date: DATE
Source a: AAA
Source b: BBB
"""

for line in sys.stdin:
	line = line.strip()
	if len(line) == 0: continue
	print "### "
	isGrammatical = "g"
	if line.startswith("*"): isGrammatical = "u" 
	print "Source: \nVetted: \nJudgment: " + isGrammatical
	print "Phenomena: " + phenomena
	
	print line.replace("*", "")
	
	words = line.split()
	buf1 = buf2 = ""
	for w in words:
		w = w.replace("*", "")
		if pronunciation.has_key(w): 
			buf1 += pronunciation[w]
			buf2 += gloss[w]
		else:  
			buf1 += w
			buf2 += w
		buf1 += " "
		buf2 += " "
	print buf1.strip()
	print buf2.strip()
	print "TRANSLATION"


	print ""
