MYPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$STANFORD_SEGMENTER_PATH/segment.sh ctb $1 UTF-8 0 2>/dev/null | java -mx2g -cp $STANFORD_TAGGER_PATH/stanford-postagger.jar: edu.stanford.nlp.tagger.maxent.MaxentTagger -model $STANFORD_TAGGER_PATH/models/chinese-distsim.tagger 2>/dev/null | python $MYPATH/tag2yy.py


#$ java -classpath "stanford-postagger.jar:lib/*" edu.stanford.nlp.tagger.maxent.MaxentTagger -prop /home/damiano/modelli/italian.tagger.props -model italian.tagger -trainFile italian.tagger.train

