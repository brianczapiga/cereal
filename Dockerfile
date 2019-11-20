from ubuntu:16.04

RUN apt-get update && apt-get install -y libzmq3-dev clang wget git autoconf libtool scons curl make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
RUN pyenv install 3.7.3
RUN pyenv global 3.7.3
RUN pyenv rehash
RUN pip3 install pyyaml==5.1.2 Cython==0.29.14

WORKDIR /project
COPY install_capnp.sh .
RUN ./install_capnp.sh

COPY . .
RUN scons -c --test && scons -j$(nproc) --test