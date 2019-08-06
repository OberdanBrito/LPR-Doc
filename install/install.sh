#!/bin/bash

#Arquivos runtime data
cp -fv /usr/share/openalpr/runtime_data/ocr/tessdata/* /usr/share/openalpr/runtime_data/ocr/
cp -fv ./br.conf /usr/share/openalpr/runtime_data/config/
cp -fv ./br2.conf /usr/share/openalpr/runtime_data/config/
cp -fv ./lbr.traineddata /usr/share/openalpr/runtime_data/ocr/tessdata/
cp -fv ./lbr.traineddata /usr/share/openalpr/runtime_data/ocr/
cp -fv ./br.patterns /usr/share/openalpr/runtime_data/postprocess/
cp -fv ./br.xml /usr/share/openalpr/runtime_data/region/
cp -fv ./br2.xml /usr/share/openalpr/runtime_data/region/

#Arquivos de configuracao
cp -fv ./alprd.conf /etc/openalpr/
cp -fv ./openalpr.conf /etc/openalpr/

#Registro do servico de captura para o banco de dados
cp -fv ./lprserver.service /etc/systemd/system/lprserver.service

chmod 644 /etc/systemd/system/lprserver.service

#Habilita o servico symlink from /etc/systemd/system/multi-user.target.wants/lprserver.service to /etc/systemd/system/lprserver.service.
systemctl enable lprserver.service

#Inicia o servico
systemctl start lprserver.service

#Verifica o PID do servico
ps -ef | grep index.js