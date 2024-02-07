#!/bin/bash
set -e
sudo docker build -t m5stack .
esp_rfc2217_server.py -p 4000 /dev/tty.usbserial-655A0C5F8D > /dev/null 2>&1 &
pid=$!
sudo docker run -it --rm -v ./src:/mpy_src m5stack /bin/bash -c 'cp -rf /mpy_src/* /project/uiflow_micropython/m5stack/fs/user/ && . /project/esp-idf/export.sh && PORT="rfc2217://host.docker.internal:4000?ign_set_control" BOARD="M5STACK_StickC_PLUS" make flash_all'
kill $pid
screen /dev/tty.usbserial-655A0C5F8D 115200