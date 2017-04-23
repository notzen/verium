#!/bin/bash
# create multiresolution windows icon
ICON_DST=../../src/qt/res/icons/verium.ico

convert ../../src/qt/res/icons/verium-16.png ../../src/qt/res/icons/verium-32.png ../../src/qt/res/icons/verium-48.png ${ICON_DST}
