#!/bin/sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
cp self.cert /etc/nginx/snippets/

# NOTE:
# add `include snippets/self-signed.conf' and `snippets/self-params.conf'
# to /etc/nginx/sites-available/file

