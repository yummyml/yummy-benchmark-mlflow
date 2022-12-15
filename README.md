# Yummy mlflow benchmark

## Introduction

The purpose of this benchmark is the comparison of the performance of models served using `mlflow`
and `yummy` implementation. Currently only `lightgbm` and `catboost` local models (eg. you can't fetch mlflow model from s3) 
are supported. Exposed API is compatible with `mlflow`. 

## Running benchmark

To reproduce test please follow steps:

### Build docker images

`./build.sh` - will build all required docker images

* `vegeta` - [vegeta attack](https://github.com/tsenart/vegeta) which will be used to run benchmark for required traffic
* `mlflow` - simple images with `mlflow`, `lightgbm` and `catboost` installed which will be used to train the models and serve them using `mlflow`
* `yummy` - which will be used to serve `mlflow` models with `rust`

### Train

`./train.sh` - will train three simple models: `lightgbm` (binary classifier, multiclass clasifier), `catboost` (binary classifier)


### Run benchmark

`./run_test_mlflow.sh` - will run the benchmark for mlflow
`./run_test_yummy.sh` - will run the benchmark for yummy

The benchamark reports will be saved to: `output-mlflow-mlflow` and 'output-yummy-mlflow` respectively.

In the benchmark we will increase number of requests per second (RPS) from 10 to 1000 for all models. 

### Results

I have used single of the model server (on my laptop).

#### LightGbm - Multiclass

##### Yummy
| RPS  | Response time  | CPU     | Memory   |
|:----:|:--------------:|:-------:|:--------:|
| 10   | 5.8  ms        |  5%     | 103.6 Mb |
| 20   | 5.3  ms        |  7%     | 103.6 Mb |
| 30   | 5.2  ms        |  11%    | 103.6 Mb |
| 40   | 2.2  ms        |  12%    | 103.6 Mb |
| 50   | 1.8  ms        |  13%    | 103.6 Mb |
| 60   | 1.8  ms        |  15%    | 103.6 Mb |
| 70   | 1.7  ms        |  17%    | 103.6 Mb |
| 80   | 1.7  ms        |  19%    | 103.7 Mb |
| 90   | 1.6  ms        |  20%    | 103.7 Mb |
| 100  | 1.6  ms        |  21%    | 103.7 Mb |
| 200  | 1.4  ms        |  39%    | 103.7 Mb |
| 300  | 1.3  ms        |  55%    | 103.7 Mb |
| 400  | 1.3  ms        |  75%    | 103.7 Mb |
| 500  | 1.2  ms        |  85%    | 103.7 Mb |
| 600  | 1.3  ms        |  103%   | 103.7 Mb |
| 700  | 1.2  ms        |  122%   | 103.7 Mb |
| 800  | 1.2  ms        |  152%   | 103.7 Mb |
| 900  | 1.2  ms        |  159%   | 103.7 Mb |
| 1000 | 1.2  ms        |  180%   | 103.7 Mb |

##### MLflow
| RPS  | Response time  | CPU     | Memory   |
|:----:|:--------------:|:-------:|:--------:|
| 10   | 1.965 s        |  45%    | 595.9 Mb |
| 20   | 14.5 ms        |  70%    | 595.3 Mb |
| 30   | 11.9 ms        |  80%    | 595.6 Mb |
| 40   | 11.8 ms        | 110%    | 595.6 Mb |
| 50   | 11.5 ms        | 120%    | 595.6 Mb |
| 60   | 11.6 ms        | 170%    | 596.9 Mb |
| 70   | 19.3 ms        | 225%    | 597.1 Mb |
| 80   | 12.5 ms        | 270%    | 597.1 Mb |
| 90   | 34.6 ms        | 284%    | 597.1 Mb |
| 100  | 29.6 ms        | 330%    | 597.1 Mb |
| 200  | 5 s (timout)   | >1000%  | 597.1 Mb |
| 300  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 400  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 500  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 600  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 700  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 800  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 900  | 5 s (timout)   | >1000%  | 103.7 Mb |
| 1000 | 5 s (timout)   | >1000%  | 103.7 Mb |

#### LightGbm - Binary

##### Yummy
| RPS  | Response time  | CPU     | Memory   |
|:----:|:--------------:|:-------:|:--------:|
| 10   | 5.5  ms        |  5%     | 109.3 Mb |
| 20   | 5.6  ms        |  9%     | 109.3 Mb |
| 30   | 5.3  ms        |  11%    | 109.3 Mb |
| 40   | 5.0  ms        |  13%    | 109.3 Mb |
| 50   | 1.8  ms        |  14%    | 109.3 Mb |
| 60   | 1.7  ms        |  14%    | 109.3 Mb |
| 70   | 1.7  ms        |  16%    | 109.3 Mb |
| 80   | 1.7  ms        |  18%    | 109.3 Mb |
| 90   | 1.7  ms        |  20%    | 109.3 Mb |
| 100  | 1.7  ms        |  22%    | 109.3 Mb |
| 200  | 1.5  ms        |  40%    | 109.3 Mb |
| 300  | 1.4  ms        |  55%    | 109.3 Mb |
| 400  | 1.3  ms        |  77%    | 109.3 Mb |
| 500  | 1.3  ms        |  95%    | 109.3 Mb |
| 600  | 1.3  ms        |  105%   | 109.3 Mb |
| 700  | 1.3  ms        |  123%   | 109.3 Mb |
| 800  | 1.3  ms        |  141%   | 109.3 Mb |
| 900  | 1.3  ms        |  165%   | 109.3 Mb |
| 1000 | 1.4  ms        |  185%   | 109.3 Mb |

##### MLflow
| RPS  | Response time  | CPU     | Memory   |
|:----:|:--------------:|:-------:|:--------:|
| 10   | 1.6   s        |  25%    | 623.5 Mb |
| 20   | 15.6 ms        |  70%    | 623.9 Mb |
| 30   | 14.9 ms        |  85%    | 624.1 Mb |
| 40   | 14.1 ms        | 140%    | 624.6 Mb |
| 50   | 17.9 ms        | 220%    | 625.1 Mb |
| 60   | 15.1 ms        | 230%    | 625.3 Mb |
| 70   | 17.8 ms        | 250%    | 625.3 Mb |
| 80   | 14.7 ms        | 270%    | 625.5 Mb |
| 90   | 17.1 ms        | 280%    | 625.7 Mb |
| 100  | 43.2 ms        | 300%    | 625.7 Mb |
| 200  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 300  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 400  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 500  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 600  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 700  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 800  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 900  | 5 s (timout)   | >1000%  | 625.9 Mb |
| 1000 | 5 s (timout)   | >1000%  | 625.9 Mb |

#### Catboost - Binary

##### Yummy
| RPS  | Response time  | CPU     | Memory   |
|:----:|:--------------:|:-------:|:--------:|
| 10   | 2.0  ms        |  0.4%   | 9.1 Mb   |
| 20   | 1.9  ms        |  0.7%   | 9.1 Mb   |
| 30   | 1.6  ms        |  0.9%   | 9.2 Mb   |
| 40   | 1.7  ms        |  1.1%   | 9.3 Mb   |
| 50   | 2.0  ms        |  1.3%   | 9.4 Mb   |
| 60   | 1.9  ms        |  1.7%   | 9.5 Mb   |
| 70   | 1.8  ms        |  1.8%   | 9.5 Mb   |
| 80   | 1.8  ms        |  1.9%   | 9.5 Mb   |
| 90   | 1.6  ms        |  2.0%   | 9.5 Mb   |
| 100  | 1.8  ms        |  2.2%   | 9.5 Mb   |
| 200  | 0.5  ms        |  3.5%   | 9.5 Mb   |
| 300  | 0.5  ms        |  5.3%   | 9.5 Mb   |
| 400  | 0.5  ms        |  6.7%   | 9.5 Mb   |
| 500  | 0.4  ms        |  7.3%   | 9.5 Mb   |
| 600  | 0.4  ms        |  8.3%   | 9.5 Mb   |
| 700  | 0.4  ms        | 10.5%   | 9.5 Mb   |
| 800  | 0.4  ms        | 11.5%   | 9.5 Mb   |
| 900  | 0.4  ms        | 13.1%   | 9.5 Mb   |
| 1000 | 1.4  ms        | 14.8%   | 9.5 Mb   |

##### MLflow
| RPS  | Response time  | CPU     | Memory   |
|:----:|:--------------:|:-------:|:--------:|
| 10   | 937   s        |  7.5%   | 513.3 Mb |
| 20   | 18.3 ms        | 14.1%   | 513.5 Mb |
| 30   |  8.8 ms        | 20.5%   | 513.8 Mb |
| 40   |  7.8 ms        | 27.1%   | 514.1 Mb |
| 50   | 19.8 ms        | 35.1%   | 514.7 Mb |
| 60   | 12.8 ms        | 37.8%   | 515.3 Mb |
| 70   |  8.4 ms        | 44.9%   | 515.3 Mb |
| 80   |  7.0 ms        | 54.5%   | 515.7 Mb |
| 90   |  6.8 ms        | 56.5%   | 515.9 Mb |
| 100  |  7.1 ms        | 65.6%   | 515.7 Mb |
| 200  |  7.6 ms        | 130.9%  | 516.2 Mb |
| 300  |  8.0 ms        | 198.6%  | 516.8 Mb |
| 400  | 44.4 ms        | 256.5%  | 517.2 Mb |
| 500  | 138.7  ms      | 408.6%  | 517.1 Mb |
| 600  | 1.1  s         | 434.3%  | 517.6 Mb |
| 700  | 5 s (timout)   | >1000%  | 517.7 Mb |
| 800  | 5 s (timout)   | >1000%  | 517.7 Mb |
| 900  | 5 s (timout)   | >1000%  | 517.7 Mb |
| 1000 | 5 s (timout)   | >1000%  | 517.7 Mb |

## Thanks

The code from [https://github.com/feast-dev/feast-benchmarks](https://github.com/feast-dev/feast-benchmarks)
was very helpful for creating this benchmark.
