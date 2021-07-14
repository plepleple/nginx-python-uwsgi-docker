FROM debian:buster

# update, upgrade system and install necessary packages
RUN apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y \
        wget \
        curl \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        nginx

# download and compile Python 3.9.2
WORKDIR /home/root
RUN wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
RUN tar xvf Python-3.9.2.tgz
WORKDIR /home/root/Python-3.9.2
RUN ./configure --enable-optimizations --with-ensurepip=install
RUN make -j 2
RUN make install
# upgrade pip
RUN /usr/local/bin/python3.9 -m pip install --upgrade pip

# install PIP necesary packages
RUN pip3 install \
    wheel \
    uwsgi \
    flask 
