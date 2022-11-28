#!/usr/bin/env python

import sys
import json
import yummy_mlflow

if __name__ == "__main__":
    model_index=int(sys.argv[1])
    model_path="/".join(json.loads(open("models_list.json").read())[model_index].split("/")[:-1])
    print(model_path)
    yummy_mlflow.model_serve(model_path, '0.0.0.0',8080,'error')
