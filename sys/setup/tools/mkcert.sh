#!/bin/sh

if [ $EUID -eq 0 ]; then
    echo "You cannot be root."
    exit 1
fi

openssl genrsa 1024 > file.pem
openssl req -new -key file.pem -out csr.pem
openssl x509 -req -days 365 -in csr.pem -signkey file.pem -out file.crt
