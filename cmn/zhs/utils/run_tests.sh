#running regression_test and calculating coverage
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

rm -rf ../tsdb/gtest/*

echo "REGRESSION TEST"
./regression_test.sh

echo "COVERAGE TEST"
./coverage.sh $@







