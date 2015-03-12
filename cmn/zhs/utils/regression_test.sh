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

while read LINE
do           
	#echo "Parsing: " $LINE
	python3 $GTESTPATH/gTest.py -G .. -C :zhs.dat -W ../tsdb/gtest/comparison R :$LINE

done < COMPARISON

while read LINE
do           
	#echo "Parsing: " $LINE
	rm -rf ../tsdb/gtest/parse/$LINE
	mkprof -s ../tsdb/skeletons/$LINE ../tsdb/gtest/parse/$LINE
	art -a "ace -g ../zhs.dat -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/gtest/parse/$LINE

	rm -rf ../tsdb/gtest/unk/$LINE
	mkprof -s ../tsdb/skeletons/$LINE ../tsdb/gtest/unk/$LINE
	art -Ya "python cmn2yy.py | ace -g ../zhs.dat -y -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/gtest/unk/$LINE

	rm -rf ../tsdb/gtest/bridge/$LINE
	mkprof -s ../tsdb/skeletons/$LINE ../tsdb/gtest/bridge/$LINE
	art -a "ace -g ../zhs-robust.dat -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/gtest/bridge/$LINE

	rm -rf ../tsdb/gtest/unk+bridge/$LINE
	mkprof -s ../tsdb/skeletons/$LINE ../tsdb/gtest/unk+bridge/$LINE
	art -Ya "python cmn2yy.py | ace -g ../zhs-robust.dat -y -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/gtest/unk+bridge/$LINE

done < COVERAGE






