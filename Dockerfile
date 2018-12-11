FROM ubuntu:18.04

RUN apt-get update

# 修改时区
RUN set -e && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get install -y build-essential


RUN apt-get -y install python3-tk wget

# install ghostscript
RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/ghostscript-9.26.tar.gz -O ghostscript-9.26.tar.gz && \
    tar zxvf ghostscript-9.26.tar.gz && \
    cd ghostscript-9.26 && \
    ./configure && \
    make all && \
    make install

RUN apt-get -y install python3-pip
RUN pip3 install camelot-py

# install opencv
RUN pip3 install opencv-python && \
        pip3 install opencv-contrib-python

RUN apt-get -y install libsm6 libxrender1 libxext-dev

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

VOLUME /tmp

COPY pdf_table_to_csv.py /root/pdf_table_to_csv.py
COPY docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod 755 /root/docker-entrypoint.sh

WORKDIR /root

#EXPOSE 8000

#ENTRYPOINT ["python3", "pdf_table_to_csv.py"]

CMD ["docker-entrypoint.sh"]

# docker build -t pdf_table_extraction:20181210 --no-cache -f Dockerfile .
# docker run --rm -it -v $PWD:/tmp pdf_table_extraction:20181210 ./docker-entrypoint.sh table.pdf json


