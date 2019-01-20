#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"

int main() {
  init_plantform();

  // Input
  __int128 KEY = 1;
  uint16_t x0 = 1;
  uint16_t x1 = 2;
  uint16_t x2 = 3;
  uint16_t x3 = 4;
  char criptare = 0;

  // Generare subchei
  uint16_t *K = (uint16_t*) calloc(16, 1);
  uint16_t *p = (uint16_t*)(&KEY);
  for (int i = 0; i < 8; i++)
    K[i] = *(p + i);

  for (int i = 8; i < 52; i++) {
    if (i % 8 == 0)
      KEY = KEY << 25 | KEY >> 103;

    K[i] = *(p + i % 8);
  }

  // Criptare

  if (criptare == 0) {
    uint16_t s0 = x0;
    uint16_t s1 = x1;
    uint16_t s2 = x2;
    uint16_t s3 = x3;
    uint16_t pas1, pas2, pas3, pas4, pas5, pas6, pas7, pas8, pas9, pas10;

    for (int i = 0; i < 8; i++) {
      pas1 = (s0 * K[i * 6]) % 65536 + 1;
      pas2 += K[i * 6 + 1];
      pas3 += K[i * 6 + 2];
      pas4 = (s3 * K[i * 6 + 3]) % 65536 + 1;
      pas5 = s0 ^ s2;
      pas6 = s1 ^ s3;
      pas7 = (pas5 * K[i * 6 + 4]) % 65536 + 1;
      pas8 = pas6 + pas7;
      pas9 = (pas8 * K[i * 6 + 5]) % 65536 + 1;
      pas10 = pas7 + pas9;

      s0 = pas1 ^ pas9;
      s1 = pas3 ^ pas9;
      s2 = pas2 ^ pas10;
      s3 = pas4 ^ pas10;
    }

    s0 = (s0 * K[0]) % 65536 + 1;
    s1 += K[1];
    s2 += K[2];
    s3 = (s3 * K[3]) % 65536 + 1;

    xil_printf("%d", s0);
    xil_printf("%d", s1);
    xil_printf("%d", s2);
    xil_printf("%d", s3);
  }

  cleanup_platform();

  return 0;
}