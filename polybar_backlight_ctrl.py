#!/usr/bin/python3
import argparse
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(description='Simple polybar backlight control script')
    subparsers = parser.add_subparsers(dest="request")
    subparsers.add_parser('get')
    inc_parser = subparsers.add_parser('inc')
    inc_parser.add_argument('val', type=int)
    dec_parser = subparsers.add_parser('dec')
    dec_parser.add_argument('val', type=int)

    args = parser.parse_args()
    if args.request == "get":
        handle_get_request()
    elif args.request == "inc":
        handle_inc_request(args.val)
    elif args.request == "dec":
        handle_dec_request(args.val)
    else:
        parser.print_help()


def handle_get_request():
    raw_out = subprocess.check_output(["light", "-G"])
    out = raw_out.decode("utf8")
    out = out.strip("\r\n")
    sys.stdout.write(str(int(float(out))) + "%")


def handle_inc_request(value):
    subprocess.check_call(["light", "-A", str(value)])


def handle_dec_request(value):
    subprocess.check_call(["light", "-U", str(value)])


if __name__ == "__main__":
    main()


