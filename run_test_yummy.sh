#!/bin/bash

#docker network create -d bridge app_default
NUM_SERVERS=1
NAME="yummy-mlflow"
TARGET=http://$NAME

echo "#######################"
echo "### TESTING MODEL 0 ###"
echo "#######################"

echo "##################"
echo "### INITIALIZE ###"
echo "##################"
for i in $(seq 0 1 $NUM_SERVERS); do
  echo "running: $NAME-$i"

  docker run --rm -d --name $NAME-$i \
	  -v $(pwd)/benchmark:/benchmark \
	  --network app_default \
	  qooba/yummy-mlflow:yummy /app/run.py 0
done


echo "##########################"
echo "### RUNNING BENCHMARK ###"
echo "##########################"
mkdir $(pwd)/output-$NAME
docker run --rm -it --name vegeta \
	  -v $(pwd)/benchmark:/benchmark \
	  -v $(pwd)/output-$NAME:/output \
	  --network app_default \
	  -e NUM_SERVERS=$NUM_SERVERS \
	  -e TARGET=$TARGET \
	  -e MODEL=0 \
	  qooba/yummy-mlflow:vegeta \
	  ./run-benchmark.sh


echo "################"
echo "### CLEAN UP ###"
echo "################"
for i in $(seq 0 1 $NUM_SERVERS); do
  echo "shutting down: $NAME-$i"

  docker stop $NAME-$i
done
