FROM ubuntu:18.04


ENV MONGO_C_VERSION=1.17.6
ENV MONGO_CXX_VERSION=r3.6.5

WORKDIR /build/

RUN apt-get update && apt-get update && apt-get install -y libcurl4-gnutls-dev perl libssl-dev libsasl2-dev && \
    apt-get install -y unzip wget gcc g++ make cmake git && \
    wget https://github.com/mongodb/mongo-c-driver/releases/download/${MONGO_C_VERSION}/mongo-c-driver-${MONGO_C_VERSION}.tar.gz && tar xzf mongo-c-driver-${MONGO_C_VERSION}.tar.gz && \
    cd /build/mongo-c-driver-${MONGO_C_VERSION} && \
    cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=OFF . && \
    make && make install && cd ../ && \
    wget https://github.com/mongodb/mongo-cxx-driver/releases/download/${MONGO_CXX_VERSION}/mongo-cxx-driver-${MONGO_CXX_VERSION}.tar.gz && tar -xzf mongo-cxx-driver-${MONGO_CXX_VERSION}.tar.gz && \
    cd /build/mongo-cxx-driver-${MONGO_CXX_VERSION} && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=OFF . && \
    make && make install && \
    apt-get remove -y unzip wget gcc g++ make cmake git && cd / && \
    rm -r /build
