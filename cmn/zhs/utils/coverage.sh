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

best=5
timeout=5
max_chart=512
max_unpack=512
dataset=COVERAGE

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
    -d|--data)
      dataset=${2};
      shift 2;
    ;;
    *)
    echo "usage: ./coverage.sh(./run_tests.sh) [ -d|--data DATASET_LIST_FILENAME ] [ -b|--best n ] [ -t|--timeout sec ] [ --max-chart-megabytes mb ] [ --max-unpack-megabytes mb ]";
    exit 1;
  esac
done

OPT="-n $best --timeout=$timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack"
#"-n 5 --timeout=5 --max-chart-megabytes=512 --max-unpack-megabytes=512"

ace -g ../ace/config.tdl -G ../zhs.dat
ace -g ../ace/config-robust.tdl -G ../zhs-robust.dat
ace -g ../ace/config-strict.tdl -G ../zhs-strict.dat

cat DEV HELDOUT TEST | sort -u > COVERAGE

mkdir -p ../tsdb/gtest/log

while read LINE
do           
	rm -rf ../tsdb/gtest/log/$LINE.log

	echo "Parsing - " $LINE

	echo "        : ordinary" 
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs.dat -W ../tsdb/gtest/parse C :$LINE >> ../tsdb/gtest/log/$LINE.log

	echo "        : unk" 
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs.dat -YP "python cmn2yy.py" -W ../tsdb/gtest/unk C :$LINE >> ../tsdb/gtest/log/$LINE.log

	echo "        : br" 
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs-robust.dat -W ../tsdb/gtest/br C :$LINE >> ../tsdb/gtest/log/$LINE.log

	echo "        : unk+br" 
	python3 $GTESTPATH/gTest.py --ace-opts "\"$OPT\"" -G .. -C :zhs-robust.dat -YP "python cmn2yy.py" -W ../tsdb/gtest/unk+br C :$LINE >> ../tsdb/gtest/log/$LINE.log

	echo "Generating - " $LINE

	rm -rf generation.tmp
	./make-preference.sh ../tsdb/gtest/parse/$LINE/ 0 > ../tsdb/gtest/parse/$LINE/preference 
	mkprof -s ../tsdb/gtest/parse/$LINE ../tsdb/gtest/gen/$LINE > /dev/null
	art -a "ace -g ../zhs-strict.dat -e -n 1 --max-chart-megabytes=2048 --max-unpack-megabytes=2048" -e ../tsdb/gtest/parse/$LINE ../tsdb/gtest/gen/$LINE > generation.tmp
	TOTAL=`grep " results" generation.tmp | wc -l`
	GENERATED=`grep "1 results" generation.tmp | wc -l`
	echo "$GENERATED $TOTAL" > ../tsdb/gtest/log/$LINE.gen
	rm -rf generation.tmp

done < $dataset

python formoin.py ../tsdb/gtest/log > ../tsdb/gtest/log/$dataset.txt

echo "COVERAGE TEST COMPLETED!"
echo "All the log files are under ../tsdb/gtest/log/ and see ../tsdb/gtest/log/$dataset.txt for updating ZhongHistory." 

