#!/bin/bash

#docker network create -d bridge app_default
docker run --rm -it --name mlflow -v $(pwd)/benchmark:/benchmark -w /benchmark --network app_default qooba/yummy-mlflow:mlflow ./train.py
