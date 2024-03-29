#!/bin/bash/env python3

# Author:                       Marcus Nogueira
# Date of latest revision:      02/26/2024
#
# RESOURCE:
#   Banner grabbing - https://www.hackingarticles.in/multiple-ways-to-banner-grabbing/
#
# REQUIREMENTS
# For this lab you’ll need to develop and test your Python script from a Linux VM with the tools Nmap, Netcat, and Telnet installed.
#
# In Python create a script that executes from a Linux box to perform the following:
#   - Prompts the user to type a URL or IP address.
#   - Prompts the user to type a port number.
#   - Performs banner grabbing using netcat against the target address at the target port; prints the results to the screen then moves on to the step below.
#   - Performs banner grabbing using telnet against the target address at the target port; prints the results to the screen then moves on to the step below.
#   - Performs banner grabbing using Nmap against the target address of all well-known ports; prints the results to the screen.

import os
import logging

if not os.path.exists("temp"):
    os.makedirs("temp")

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    handlers=[
                        logging.FileHandler('temp/file_detector_log.log'),
                        # logging.StreamHandler()
                    ])


def banner():
    print("""
┏┓•            •   
┣ ┓┏┓┏┓┏┓┏┓┏┓┏┓┓┏┓╋
┻ ┗┛┗┗┫┗ ┛ ┣┛┛ ┗┛┗┗
      ┛    ┛       
    """)


def user_input(target):
    try:
        input_value = str(input(f'Enter {target}: '))
        logging.info(f'User input for {target}: {input_value}')
        return input_value
    except KeyboardInterrupt:
        logging.warning("User initiated exit.")
        exit()


def target_ip():
    while True:
        ipaddr = user_input("Target Address")
        target_port = user_input("PORT")

        confirm = input(f'Target: {ipaddr} {target_port} [Y/n]: ') or "Y"
        if confirm.upper() == 'Y':
            return [ipaddr, target_port]
        print("Please enter the target.")


def ncat(ip, port):
    print("\nNetcat Scan Starting:")
    command = f'nc {ip} {port}'
    os.system(command)


def tnet(ip, port):
    print("\nTelnet Connection Test:")
    command = f'telnet {ip} {port}'
    os.system(command)


def nmap_scan(ip):
    print()
    command = f'nmap -sV -top-ports 1024 {ip}'
    os.system(command)


def main():
    banner()
    target = target_ip()
    ncat(*target)
    tnet(*target)
    nmap_scan(target[0])


if __name__ == "__main__":
    main()
