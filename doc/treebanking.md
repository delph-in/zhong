# TREEBANKING TOOL fftb

It uses ACE 0.9.23., which is in /home/zhenzhen/logon/lingo/answer/bin/linux.x86.64/ace
/home/zhenzhen/bin/ace is 0.9.24
use `which ace` to find out ACE version
`echo $PATH`  to see the PATH parameter values
```
export PATH=/home/zhenzhen/logon/lingo/answer/bin/linux.x86.64/:$PATH 
```
to add the ace path to PATH

In ~/zhong/cmn/zhs
1. make profile skeleton of the test suite first (/home/zhenzhen/tools/fftrain-0.9.25/README)
```mkprof -s tsdb/skeletons/cmnedu ~/treebank/cmnedu-20170724.2
```

2.parse the profile/sentences to get trees
```art -f -a '/home/zhenzhen/logon/lingo/answer/bin/linux.x86.64/ace --disable-generalization -g zhs.dat -O' ~/treebank/cmnedu-20170724.2
```

3. treebank with existing trees: 
```
/home/zhenzhen/logon/lingo/answer/bin/linux.x86.64/fftb -g zhs.dat --browser --webdir=$LOGONROOT/lingo/answer/fftb --gold ~/treebank/cmnedu-20170724.3 ~/treebank/cmnedu-20170724.3
```

when editing, use this to compile grammar:
```
/home/zhenzhen/logon/lingo/answer/bin/linux.x86.64/ace -G zhs_9.23.dat -g ace/config.tdl
```

# Train a ranking model from treebank

compile grammar using ACE 0.9.25 first
```
~/tools/ace-0.9.25/ace -G ~/zhong/cmn/zhs/zhs_9.25.dat -g ~/zhong/cmn/zhs/ace/config.tdl
```

Create a master, then use a worker to train the model
```
FFGRANDPARENT=0 ./ffmaster 1 cmnedu.mem &
FFGRANDPARENT=0 ./ffworker ~/zhong/cmn/zhs/zhs.9.25.dat ~/treebank/cmnedu-20170724.3 ~/treebank/cmnedu-20170724.3 localhost
```

Testing the ranking model with one sentence, showing only the best parse (`-1Tf`). Use `-Tf` for all parses. 
```bash
echo "我 刚才 去 邮局 给 我 妈妈 寄 了 点儿 东西 " | ~/tools/ace-0.9.25/ace -g ~/zhong/cmn/zhs/zhs.dat -1Tf --maxent=cmnedu.mem
```

Another way to call the worker to train the model
```
FFGRANDPARENT=1 ./ffworker ~/zhong/cmn/zhs/zhs.dat ~/treebank/cmnedu-20170724.3 ~/treebank/cmnedu-20170724.3 localhost
```

