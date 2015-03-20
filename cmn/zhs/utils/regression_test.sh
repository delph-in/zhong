#regression_test.sh
# ACEROOT, ARTROOT, PYDELPHINROOT, PYTHONPATH, and GTESTPATH should be registered in your ~/.bashrc, e.g,
#   export ACEROOT=/gtest/sanghoun/tools/ace
#   export PATH=$PATH:$ACEROOT
#   export ARTROOT=/gtest/sanghoun/tools/art
#   export PATH=$PATH:$ARTROOT
#   export ARTROOT=/gtest/sanghoun/tools/art
#   export PATH=$PATH:$ARTROOT
#   export PYDELPHINROOT=/home/sanghoun/tools/pydelphin
#   export PATH=$PATH:$PYDELPHINROOT
#   export PYTHONPATH=~/tools/pydelphin:"$PYTHONPATH"
#   export GTESTPATH=/home/sanghoun/tools/gtest

ace -g ../ace/config.tdl -G ../zhs.dat
mkdir -p ../tsdb/gtest/comparison

while read LINE
do         
	python3 $GTESTPATH/gTest.py -G .. -C :zhs.dat -W ../tsdb/gtest/comparison R :$LINE
done < COMPARISON

echo "REGRESSION TEST COMPLETED!"

