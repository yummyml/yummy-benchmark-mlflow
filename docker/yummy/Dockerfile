FROM python:3.9.13
RUN pip3 install -i https://test.pypi.org/simple/ yummy-rs~=0.0.6.2
WORKDIR /benchmark
COPY run.py /app/run.py
CMD /app/run.py
