# Arduino LCD Video
## About
This repository contains a script to convert a video file into a series of ditheres bitmaps that can be played as a short clip via Arduino.

## Demo:
Using the the file `konredus-techlab.mp4` (the intro of [https://www.youtube.com/watch?v=RouVbZltVII](https://www.youtube.com/watch?v=RouVbZltVII)), we get the following:

![](demo.gif)

## Requirements

Required tools:
- bash
- imagemagick
- ffmpeg
- enough RAM on your Arduino to store the frames

## Example
In a bash shell run: 
```
./convert.sh konredus-techlab.mp4 84x48 51
```
This will generate the files `frame_*.h` and `video.h`.

The parameters are
- *konredus-techlab.mp4* - the video file to be converted to `*.h`
- *84x48* - the output resolution (centered)
- *51* - the number of frames to store on the device (RAM)

The example Arduino code works with a Wemos D1 mini (ESP8266) and a Nokia5110 display, wired as follows (Nokia -> D1mini):

- GND -> GND
- BL -> 3V3
- VCC -> 3V3
- CLK -> D5
- DIN -> D7
- DC -> D4
- CE -> D8
- RST -> D3

Then, open the Arduino project and flash the example to the D1mini.

## TODO:
- Store more frames in PROGMEM