# LEMP stack web-server (local dev)

** This Docker container is used for local development on your machine and is not mean't for production environments **

LEMP stack contains the following containers

1. Nginx web-server
2. PHP7 (php-fpm)
3. MariaDB database 
4. Mailcatcher (reading mails locally without outbound delivery to the internet)



# Installation

## Generate SSL (unsigned)

The nginx configuration is expecting SSL certificate files to exist.  Please generate before starting docker-compose.

```bash
$ cd scripts
$ ./generate_ssl.sh
```

### Launch docker-compose
```bash
$ cd ..
$ docker-compose up
```

### Test your webserver

Load up ``http://localhost`` in your browser to see the default landing page.


### Links

Links allow containers to communicate to each other without having to know IP addresses.

| Name        | Container           |
| ------------- |:-------------:|
| nginx | nginx container  |
| php | php container  |
| mariadb | mariadb container  |
| mailcatcher | mailcatcher container  |

Eg. to access the mariadb server in your PHP script.

```php
<?php
    $myPDO = new PDO('mysql:host=mariadb;dbname=dbname', 'username', 'password');
?>
```

### Configure nginx

The default nginx root folder is located at ``data/www/default``.  Inside you will find the default ``index.html``.  

Configuration for the default host can be found in  ``docker-files/nginx/conf.d/default.conf``.

#### Configuration files

| Configuration file        | Host           |
| ------------- |:-------------:| -----:|
| ``docker-files/nginx/conf.d/default.conf`` | http://localhost |
| ``docker-files/nginx/conf.d/sites-enabled/example.dev.conf``| http://example.dev  |


#### Root folders

| Local        | Host           |
| ------------- |:-------------:|
| ``data/www/default`` | http://localhost  |
| ``data/www/vhosts/example.dev`` | http://example.dev  |

Eg.  Creating ``data/www/default/test.html`` would be loaded as ``http://localhost/test.html`` in your browser



#### Adding additional Virtual Hosts

To add additional vhosts (eg. http://blah.dev)

1. Shutdown docker-compose ``docker-compose down``
2. Create the file ``docker-files/nginx/conf.d/sites-enabled/blah.dev.conf`` (Copy the contents from ``example.dev.conf`` if needed)
3. Create the folder ``data/www/vhosts/blah.dev`` and place your files inside.  ``index.html`` is the index file.
4. Start up docker-compose ``docker-compose up``
5. Visit ``http://blah.dev`` in your browser.  Your index page should load.


# Images

## Nginx (nginx)
- Based off from official [nginx](https://hub.docker.com/_/nginx/) image
- HTTPS enabled - unsigned certificate (run the SSL generation script)
- HTTP2 enabled


## PHP 7.1 (php)
- PHP-FPM implementation
- Built from [CentOS 7](https://hub.docker.com/r/library/centos/tags/centos7/) image

### Packages
- php-common (php-api, php-bz2, php-calendar, php-ctype, php-curl, php-date, php-exif, php-fileinfo, php-filter, php-ftp, php-gettext, php-gmp, php-hash, php-iconv, php-json, php-libxml, php-openssl, php-pcre, php-pecl-Fileinfo, php-pecl-phar, php-pecl-zip, php-reflection, php-session, php-shmop, php-simplexml, php-sockets, php-spl, php-tokenizer, php-zend-abi, php-zip, php-zlib)
- php71w-opcache
- php71w-bcmath
- php71w-cli
- php71w-common
- php71w-gd
- php71w-imap
- php71w-mbstring
- php71w-mcrypt
- php71w-mysqlnd
- php71w-pdo
- php71w-pear
- php71w-pecl-imagick
- php71w-process
- php71w-pspell
- php71w-recode
- php71w-tidy
- php71w-xml

## MariaDB (mariadb)
- Built from official [MariaDB](https://hub.docker.com/_/mariadb/) image

## MailCatcher (mailcatcher)

- Built from [ruby 2.4.1](https://hub.docker.com/r/library/ruby/tags/2.4.1-slim/) (slim) image
- SMTP port: 1025
- Admin port: 1080 (http://localhost:1080)


# TODO:
- Create scripts to restart services (eg. nginx, mariadb, php-fpm) without having to exec into containers
