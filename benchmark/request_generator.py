import click
import json
import numpy as np
import base64


@click.command()
@click.option('--endpoint', default='http://127.0.0.1', help='Feature Server endpoint')
@click.option('--num-servers', default=1, help='Number of endpoints')
@click.option('--requests', default=10**3, help='Number of requests')
@click.option('--output', default='requests.json')
@click.option('--model', default=0)
def generate_requests(endpoint, num_servers, requests, output, model):
    vegeta_requests = []

    for idx in range(requests):
        if model == 0:
            model_request = {
                "columns": ["0","1","2","3","4","5","6","7","8","9","10","11","12"],
                "data": [
                     [ 0.913333, -0.598156, -0.425909, -0.929365,  1.281985,
                       0.488531,  0.874184, -1.223610,  0.050988,  0.342557,
                      -0.164303,  0.830961,  0.997086,
                    ]
                ]
            }
        elif model == 1:
            model_request = {
                "columns": ["0","1","2","3","4","5","6","7","8","9","10",
                            "11","12","13","14","15","16","17","18","19",
                            "20","21","22","23","24","25","26","27","28",
                            "29"],
                "data": [
                     [-0.206561,  0.286311, -0.137124, -0.279260,  1.013376,  
                       0.806556,  0.699320,  0.846065,  1.111279,  1.481735,
                      -0.052594, -0.519362,  0.112343, -0.146687, -0.542348,
                      -0.158063,  0.087080,  0.250429, -0.422842,  0.079469,
                       0.029159,  0.648570,  0.179870, -0.063607,  1.097274,
                       0.835474,  1.143785,  1.377912,  1.106957,  1.493688
                    ]
                ]}
        elif model == 2:
            model_request = {
                "columns": ["age","workclass", "fnlwgt", "education", "education-num",
                            "marital-status", "occupation", "relationship", "race",
                            "sex", "capital-gain", "capital-loss", "hours-per-week", 
                            "native-country"],
                "data": [
                         [25.,"Private",226802.,"11th",7.,"Never-married",
                          "Machine-op-inspct", "Own-child", "Black", "Male",
                          0.,0.,40.,"United-States"
                         ]    
                        ]}


        vegeta_request = {
            "method": "POST",
            "url": f"{endpoint}-{idx%num_servers}:{8080}/invocations",
            "header": {"Content-Type": ["application/json"]},
            "body": base64.encodebytes(json.dumps(model_request).encode()).decode()
        }

        vegeta_requests.append(json.dumps(vegeta_request))

    with open(output, 'w') as f:
        f.write("\n".join(vegeta_requests))

    

if __name__ == '__main__':
    generate_requests()
