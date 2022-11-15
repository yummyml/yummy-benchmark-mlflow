#!/bin/bash


UNIQUE_REQUESTS_NUM=${UNIQUE_REQUESTS_NUM:-1000}
TARGET=${TARGET:-http://127.0.0.1}
NUM_SERVERS=${NUM_SERVERS:-16}
CONCURRENCY=${CONCURRENCY:-5}
RUN_TIME=${RUN_TIME:-1m}
WAIT_TIME=${WAIT_TIME:-1}
REQUEST_TIMEOUT=${REQUEST_TIMEOUT:-5s}

trap "exit" INT

single_run() {
	echo "Model: $1; RPS: $2; Concurrency: $3;"

	python3 request_generator.py \
		--endpoint ${TARGET} \
		--num-servers ${NUM_SERVERS} \
		--requests ${UNIQUE_REQUESTS_NUM} \
		--model $1 \
		--output requests-$1-$2.json

	echo "vegeta attack -format json -targets requests-$1-$2.json -connections $3 -duration ${RUN_TIME} -rate $2/1s -timeout ${REQUEST_TIMEOUT} | vegeta report"

	vegeta attack -format json -targets requests-$1-$2.json -connections $3 -duration ${RUN_TIME} -rate $2/1s -timeout ${REQUEST_TIMEOUT} | vegeta report | tee /output/output-m$1-r$2-c$3.txt

	sleep ${WAIT_TIME}
}

# single_run <model> <rps> <concurrency>

echo "Change only number of requests"

for i in $(seq 10 10 100); do single_run $MODEL $i $CONCURRENCY; done

for i in $(seq 100 100 1000); do single_run $MODEL $i $CONCURRENCY; done

