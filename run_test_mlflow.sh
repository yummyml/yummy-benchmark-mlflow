#!/bin/bash

#docker network create -d bridge app_default
NUM_SERVERS=1
NAME="mlflow-mlflow"
TARGET=http://$NAME

#MODEL=0
#MODEL_PATH=/benchmark/mlruns/2/e07c2404eee74d74820729eadc2ef803/artifacts/multiclass_lightgbm

#MODEL=1
#MODEL_PATH=/benchmark/mlruns/1/41693cb388574a74b7f1698c8867592b/artifacts/binary_lightgbm

MODEL=2
MODEL_PATH=/benchmark/mlruns/3/311b0c66133946858cffdfa5156dc242/artifacts/binary_catboost

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
	  qooba/yummy-mlflow:mlflow mlflow models serve -m $MODEL_PATH -h 0.0.0.0 -p 8080 -w 4 --no-conda
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
	  -e MODEL=$MODEL \
	  qooba/yummy-mlflow:vegeta \
	  ./run-benchmark.sh


echo "################"
echo "### CLEAN UP ###"
echo "################"
for i in $(seq 0 1 $NUM_SERVERS); do
  echo "shutting down: $NAME-$i"

  docker stop $NAME-$i
done
