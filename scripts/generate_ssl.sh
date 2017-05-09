SSL_FOLDER=../docker-files/nginx/ssl

openssl dhparam -out $SSL_FOLDER/dhparam.pem 2048
openssl genrsa -des3 -passout pass:x -out $SSL_FOLDER/server.pass.key 2048
openssl rsa -passin pass:x -in $SSL_FOLDER/server.pass.key -out $SSL_FOLDER/nginx-selfsigned.key
openssl req -new -key $SSL_FOLDER/nginx-selfsigned.key  -out $SSL_FOLDER/server.csr \
  -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"
openssl x509 -req -days 365 -in $SSL_FOLDER/server.csr -signkey $SSL_FOLDER/nginx-selfsigned.key -out $SSL_FOLDER/nginx-selfsigned.crt
rm $SSL_FOLDER/server.pass.key