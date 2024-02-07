import os, sys, io
import M5
from M5 import *
from M5 import Lcd

def connect_wifi():
    import network
    # enable station interface and connect to WiFi access point
    nic = network.WLAN(network.STA_IF)
    nic.active(True)
    nic.connect('', '')

class Wifi:
    @classmethod
    def scan(cls):
        import network
        nic = network.WLAN(network.STA_IF)
        nic.active(True)
        return nic.scan()
    @classmethod
    def ui_scan(cls):
        aps = cls.scan()
        aps = [ap for ap in aps if ap[0] != b'']
        Lcd.clear(0)
        Lcd.setCursor(0, 0)
        Lcd.print("WiFi APs:")
        for i, ap in enumerate(aps):
            Lcd.setCursor(0, (16 * (i + 1)))
            Lcd.print("%s" % (ap[0].decode('utf-8')))


def setup():

    M5.begin()
    print("Hello world,M5STACK!")

    Lcd.clear(0)
    Lcd.setCursor(int(Lcd.width() / 2) - 60, int(Lcd.height() / 2) - 15)
    Lcd.print("M5STACK")

    connect_wifi()

def loop():
  M5.update()
  Wifi.ui_scan()

if __name__ == '__main__':
  try:
    setup()
    while True:
      loop()
  except (Exception, KeyboardInterrupt) as e:
    try:
      from utility import print_error_msg
      print_error_msg(e)
    except ImportError:
      print("please update to latest firmware")


