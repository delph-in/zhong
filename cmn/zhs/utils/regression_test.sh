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

best=5
timeout=5
max_chart=256
max_unpack=256

while [ $# -gt 0 -a "${1#-}" != "$LINE" ]; do
  case ${1} in
    -b|--best)
      best=${2};
      shift 2;
    ;;
    -t|--timeout)
      timeout=${2};
      shift 2;
    ;;
    --max-chart-megabytes)
      max_chart=${2};
      shift 2;
    ;;
    --max-unpack-megabytes)
      max_unpack=${2};
      shift 2;
    ;;
    *)
    echo "usage: regression_test.sh [ --best n ] [ skeleton ]";
    exit 1;
  esac
done

ace -g ../ace/config.tdl -G ../zhs.dat
ace -g ../ace/config-robust.tdl -G ../zhs-robust.dat

rm -rf ../tsdb/gtest/*
mkdir -p ../tsdb/gtest/comparison
mkdir -p ../tsdb/gtest/log

OPT="-n $best --timeout=$timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack"

while read LINE
do           
	echo "Comparing: " $LINE
	python3 $GTESTPATH/gTest.py -G .. -C :zhs.dat -W ../tsdb/gtest/comparison R :$LINE

done < COMPARISON

while read LINE
do           
	echo "Parsing: " $LINE
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs.dat -W ../tsdb/gtest/parse C :$LINE >> ../tsdb/gtest/log/$LINE.log
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs.dat -YP "python cmn2yy.py" -W ../tsdb/gtest/unk C :$LINE >> ../tsdb/gtest/log/$LINE.log
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs-robust.dat -W ../tsdb/gtest/br C :$LINE >> ../tsdb/gtest/log/$LINE.log
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs-robust.dat -YP "python cmn2yy.py" -W ../tsdb/gtest/unk+br C :$LINE >> ../tsdb/gtest/log/$LINE.log

done < COVERAGE






