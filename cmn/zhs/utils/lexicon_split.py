################################################################
# Luis Morgado da Costa (LMC) -- 2020.02
################################################################################
# This script is used to convert lexicon files into their character based and  
# pinying counterparts.
# 
################################################################################

import argparse, sys, requests
from delphin import tdl
import pyme


def load_lexicon_file(path_to_file):
    """
    The lexicon file should be a fully spelled path. e.g.:
    '/home/lmc/git/zhong/cmn/zhs/lex-base.tdl'
    """
    lex = {}
    for event, obj, lineno in tdl.iterparse(path_to_file):
        if event == 'TypeDefinition':
            lex[obj.identifier] = obj
    return lex



def split_lexicon(lexicon, output_file):
    for l in lexicon:
        obj = lexicon[l]
        ########################################################################
        # There are some lexical item that are already split into
        # multiple characters split by spaces
        ########################################################################
        # if len(obj['STEM'].values())>1:
        #     print(lex[l].features()[0][1].values())
        ########################################################################

        if len(obj['STEM'].values())==1:
            lemma_string = obj['STEM'].values()[0]

            
            c_list = []
            for c in lemma_string:
                c_list.append(tdl.String(c))
            x = tdl.ConsList(values=c_list,
                             end=tdl.EMPTY_LIST_TYPE)

            obj['STEM'] = x
            output_file.write(tdl.format(obj))
            output_file.write("\n\n")

            
            ####################################################################
            # Write the pinyin forms to the other file
            ####################################################################
            p = pyme.pinyin(str(lemma_string)) # delphin.tdl.String doesn't work
            pin1yin1 = p[0].split()
            pinyin = pyme.py2plain(p[0]).split()
            # print(str(lemma_string), pin1yin1, pinyin)

            c_list = []
            for c in pin1yin1:
                c_list.append(tdl.String(c))
            x = tdl.ConsList(values=c_list,
                             end=tdl.EMPTY_LIST_TYPE)

            obj.identifier = obj.identifier+"_py"

            obj['STEM'] = x
            output_file_pinyin.write(tdl.format(obj))
            output_file_pinyin.write("\n\n")
            

            c_list = []
            for c in pinyin:
                c_list.append(tdl.String(c))
            x = tdl.ConsList(values=c_list,
                             end=tdl.EMPTY_LIST_TYPE)

            obj.identifier = obj.identifier+"2"
            obj['STEM'] = x
            output_file_pinyin.write(tdl.format(obj))
            output_file_pinyin.write("\n\n")

            
    return output_file
    
    

if __name__ == '__main__':
    usage = "Correct usage: python lexicon_split.py -f <lexicon_file>.tdl -o <output_file>.tdl\n\n"
    parser = argparse.ArgumentParser(
        description="Dumps given sqlite file to xml validated against ntumc.dtd")
    parser.add_argument("-f", "--inputfile", help="input file")
    parser.add_argument("-o", "--output", help="output to file")
    options = parser.parse_args()

    
    if options.inputfile and options.output:

        if not options.output.endswith(".tdl"):
            print(usage)
            print("The output file does not end in .tdl")
            sys.exit(0)


        else:
            output_name = str(options.output)[:-4]
            lexicon = load_lexicon_file(options.inputfile)
            output_file = open(output_name+"-split.tdl","w+")
            output_file_pinyin = open(output_name+"-pinyin.tdl","w+")
            split_lexicon(lexicon, output_file)

            output_file.close()
            output_file_pinyin.close()
        
    else:
        print(usage)
        sys.exit(0)
