#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Error: filename missing!"
    echo "Example: video2lcd.sh video.mov 84x48 100"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Error: resolution missing!"
    echo "Usage: video2lcd.sh video.mov 84x48 100"
    exit 1
fi

if [[ -z "$3" ]]; then
    echo "Error: frame count missing!"
    echo "Usage: video2lcd.sh video.mov 84x48 100"
    exit 1
fi
echo "Converting: $1 to $2"

# reduce the framerate via
# ffmpeg -i video30fps.mp4 -r 10 video10fps.mp4
convert $1 -thumbnail "$2^" -gravity center -extent $2 frame_%d.xbm

VIDFILE=video.h
echo "// Generated File, do not modify" > $VIDFILE
echo "#define MAX_FRAMES $3" >> $VIDFILE

for file in *.xbm; do
    # make arduino compiler happy ;)
    OUTFILE="$(basename "$file" .xbm).h"
    sed 's/char/uint8_t/g' <$file >$OUTFILE
    #sed 's/=/PROGMEM =/g' <temp.file >$OUTFILE
    #rm temp.file
    #echo "#include \"$OUTFILE\""  >> $VIDFILE
done

START=0
END=$3
for (( c=$START; c<=$END; c++ ))
do
    echo "#include \"frame_$c.h\""  >> $VIDFILE
done

echo "void drawFrame(U8G2 *u8g2, uint8_t frame, uint8_t x, uint8_t y, uint8_t w, uint8_t h) {" >> $VIDFILE
echo "" >> $VIDFILE
echo "  switch(frame) {" >> $VIDFILE

START=0
END=$3
for (( c=$START; c<=$END; c++ ))
do
    echo "case $c:" >> $VIDFILE
    echo "  u8g2->drawXBM(x,y,w,h,frame_$(echo $c)_bits);" >> $VIDFILE
    echo "  break;" >> $VIDFILE;
done

echo "  }" >> $VIDFILE
echo "}" >> $VIDFILE

rm *.xbm


