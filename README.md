# Feature servers benchmark

## Introduction

Benchmark based on [https://github.com/feast-dev/feast-benchmarks](https://github.com/feast-dev/feast-benchmarks)
which compares Feast feature server implemented in `go` and yummy feature server implemented in `rust`.
The benchmark is limited only to `redis` online store. The implementations `feast` and `yummy` have
fully compatible: request/response payloads, config (`feature_store.yaml`) and registries.

## Running benchmark

To reproduce test please follow steps:

### Build docker images

`./build.sh` - will build all required docker images

* `vegeta` - [vegeta attack](https://github.com/tsenart/vegeta) which will be used to run benchmark for required traffic
* `feast-serve` - which is based on `feastdev/feature-server:0.26.0` and will be used to apply and materialize feature store and as a Feast feature server 
* `yummy-serve` - which will be used as a Yummy feature server

### Apply and materialize

`./materialize.sh` - will run redis, apply feature store and materialize (using `feast-serve` image) it to redis


### Run benchmark

`./run_test_feast.sh` - will run the benchmark for feast   
`./run_test_yummy.sh` - will run the benchmark for yummy

The benchamr reports will be saved to: `output-feast-serve` and 'output-yummy-serve` respectively.

In the benchmark we will have three scenarios:

#### Change only number of entities we fetch 
Entities: form 10 to 100 (step 10)
Features: 50
Concurrency: 5
RPS: 10 


#### Change only number of features
Entities: 1
Features: from 50 to 250 (step 50)
Concurrency: 5
RPS: 10 


#### Change only number of requests

* 1
Entities: 1
Features: 50
Concurrency: 5
RPS: from 10 to 100 (step 10)

* 2
Entities: 1
Features: 50
Concurrency: 5
RPS: from 100 to 1000 (step 100)

* 3
Entities: 1
Features: 250
Concurrency: 5
RPS: from 10 to 100 (step 10)

* 4
Entities: 100
Features: 50
Concurrency: 5
RPS: from 10 to 100 (step 10)

* 5
Entities: 100
Features: 50
Concurrency: 5
RPS: from 10 to 100 (step 10)

### Results

Unlike benchmark presented on [Feast blog](https://feast.dev/blog/feast-benchmarks/)
I have used single or 5 instance of the feature server (on my laptop) thus results vary (on blog 16 instances on c5.4xlarge, 16 vCPU were used).

For the single instance (p99 latency, timeout 5s) for:
Entities: 1
Features: 50
Concurrency: 5
RPS: from 10 to 100 (step 10)

| RPS | Feast serve | Yummy serve |
|:---:|:-----------:|:-----------:|
| 10  |  92 ms      |  3.88 ms    |
| 20  |  timout     |  3.77 ms    |
| 30  |  timeout    |  3.74 ms    |
| 40  |  timeout    |  3.68 ms    |
| 50  |  timeout    |  3.60 ms    |
| 60  |  timeout    |  3.62 ms    |
| 70  |  timeout    |  3.56 ms    |
| 80  |  timeout    |  3.47 ms    |
| 90  |  timeout    |  3.25 ms    |
| 100 |  timeout    |  3.37 ms    |


For the 5 instances (p99 latency, timeout 5s) for:
Entities: 1
Features: 50
Concurrency: 5
RPS: from 10 to 100 (step 10)

| RPS | Feast serve | Yummy serve |
|:---:|:-----------:|:-----------:|
| 10  |  83 ms      |  4.2 ms     |
| 20  |  93 ms      |  4.0 ms     |
| 30  |  91 ms      |  4.1 ms     |
| 40  |  105 ms     |  4.0 ms     |
| 50  |  timeout    |  3.9 ms     |
| 60  |  timeout    |  3.8 ms     |
| 70  |  timeout    |  3.5 ms     |
| 80  |  timeout    |  3.4 ms     |
| 90  |  timeout    |  3.6 ms     |
| 100 |  timeout    |  1.9 ms     |

