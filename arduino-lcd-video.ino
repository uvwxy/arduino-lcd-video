#include <Arduino.h>
#include <U8g2lib.h>

#include "video.h"

#ifdef U8X8_HAVE_HW_SPI
#include <SPI.h>
#endif
#ifdef U8X8_HAVE_HW_I2C
#include <Wire.h>
#endif

U8G2_PCD8544_84X48_F_4W_HW_SPI u8g2(U8G2_R2, /* cs=D8*/ 15, /* dc=D4*/ 2, /* reset=D3*/ 0);     // Nokia 5110 Display

void setup(void) {
  u8g2.begin();
}

uint8_t i;
void loop(void) {

  for (i = 0; i < MAX_FRAMES; i++) {
    u8g2.clearBuffer();
    drawFrame(&u8g2, i, 0, 0, 84, 48);
    u8g2.sendBuffer();
    delay(1000 / 10);
  }
  delay(1000 / 10);
}
