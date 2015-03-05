#regression_test.sh
#ACEROOT and ARTROOT should be registered in your ~/.bashrc, like 
#   export ACEROOT=/home/sanghoun/tools/ace
#   export PATH=$PATH:$ACEROOT
#   export ARTROOT=/home/sanghoun/tools/art
#   export PATH=$PATH:$ARTROOT

best=5
timeout=5
max_chart=256
max_unpack=256

while [ $# -gt 0 -a "${1#-}" != "$1" ]; do
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

rm -rf ../tsdb/home/parse/$1
mkprof -s ../tsdb/skeletons/$1 ../tsdb/home/parse/$1
art -a "ace -g ../zhs.dat -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/home/parse/$1

rm -rf ../tsdb/home/unk/$1
mkprof -s ../tsdb/skeletons/$1 ../tsdb/home/unk/$1
art -Ya "python cmn2yy.py | ace -g ../zhs.dat -y -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/home/unk/$1

rm -rf ../tsdb/home/bridge/$1
mkprof -s ../tsdb/skeletons/$1 ../tsdb/home/bridge/$1
art -a "ace -g ../zhs-robust.dat -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/home/bridge/$1

rm -rf ../tsdb/home/unk+bridge/$1
mkprof -s ../tsdb/skeletons/$1 ../tsdb/home/unk+bridge/$1
art -Ya "python cmn2yy.py | ace -g ../zhs-robust.dat -y -n $best --timeout $timeout --max-chart-megabytes=$max_chart --max-unpack-megabytes=$max_unpack" ../tsdb/home/unk+bridge/$1

