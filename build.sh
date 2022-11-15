#!/bin/bash

base_path=$(pwd)
cd $base_path/docker/vegeta
docker build -t qooba/yummy-mlflow:vegeta .

cd $base_path/docker/mlflow
docker build -t qooba/yummy-mlflow:mlflow .

cd $base_path/docker/yummy
docker build -t qooba/yummy-mlflow:yummy .

cd $base_path
