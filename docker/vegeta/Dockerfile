FROM python:3.9.13

RUN curl -LO https://github.com/tsenart/vegeta/releases/download/v12.8.4/vegeta_12.8.4_linux_386.tar.gz && \
    tar zxvf vegeta_12.8.4_linux_386.tar.gz && \
    mv vegeta /usr/local/bin && \
    rm vegeta_12.8.4_linux_386.tar.gz

RUN pip install click==8.1.3 numpy==1.23.3
WORKDIR /benchmark

