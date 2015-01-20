MYPATH=$(pwd)/utils
[[ $(pwd) =~ ^.*utils$ ]] && MYPATH=$(pwd)

$STANFORD_SEGMENTER_PATH/segment.sh ctb $1 UTF-8 0 2>/dev/null | java -mx2g -cp $STANFORD_TAGGER_PATH/stanford-postagger.jar: edu.stanford.nlp.tagger.maxent.MaxentTagger -model $STANFORD_TAGGER_PATH/models/chinese-distsim.tagger 2>/dev/null | python $MYPATH/tag2yy.py

