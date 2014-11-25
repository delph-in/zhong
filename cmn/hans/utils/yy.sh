./utils/yy.py $2 $3
cat tmp.yy | ace -g $1 -yTf
rm -rf tmp.yy

