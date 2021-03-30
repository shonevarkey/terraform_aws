#!/bin/bash

yum install httpd php php-mysql -y
service httpd restart
chkconfig httpd on

echo "<?php phpinfo(); ?>" > /var/www/html/index.php
