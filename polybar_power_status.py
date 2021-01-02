#!/usr/bin/python3
import argparse
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(description='Simple polybar power status script')
    args = parser.parse_args()
    try:
        power0 = get_bat_power("BAT0")
        power1 = get_bat_power("BAT1")
        sys.stdout.write(str(power0 + power1) + "%")
    except:
        pass


def get_bat_power(bat):
    raw_out = subprocess.check_output(["cat", "/sys/class/power_supply/{}/capacity".format(bat)])
    out = raw_out.decode("utf8")
    out = out.strip("\r\n")
    return  int(float(out))


if __name__ == "__main__":
    main()


