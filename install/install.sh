#!/bin/bash

cp -fv /usr/share/openalpr/runtime_data/ocr/tessdata/* /usr/share/openalpr/runtime_data/ocr/
cp -fv ./br.conf /usr/share/openalpr/runtime_data/config/
cp -fv ./br2.conf /usr/share/openalpr/runtime_data/config/
cp -fv ./lbr.traineddata /usr/share/openalpr/runtime_data/ocr/tessdata/
cp -fv ./lbr.traineddata /usr/share/openalpr/runtime_data/ocr/
cp -fv ./br.patterns /usr/share/openalpr/runtime_data/postprocess/
cp -fv ./br.xml /usr/share/openalpr/runtime_data/region/
cp -fv ./br2.xml /usr/share/openalpr/runtime_data/region/