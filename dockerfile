from ubuntu:latest
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y python3.10 git python3.10-venv python3.10-dev python3.10-distutils

WORKDIR /project

RUN mkdir uiflow_workspace && cd uiflow_workspace
RUN git clone -b uiflow/v2.0-idf5.0.4 https://github.com/m5stack/esp-idf.git 
RUN git -C esp-idf submodule update --init --recursive
RUN ./esp-idf/install.sh
ENV IDF_PATH=/project/esp-idf
RUN apt-get -y install libusb-1.0-0
RUN apt-get -y install build-essential
RUN . ./esp-idf/export.sh

RUN git clone https://github.com/m5stack/uiflow_micropython
WORKDIR /project/uiflow_micropython/m5stack
RUN make submodules
RUN  make patch
RUN apt-get -y install cmake
RUN  make littlefs
RUN  make mpy-cross
RUN apt-get install -y python3-pip
RUN pip3 install -U future 
RUN pip3 install -U cryptography