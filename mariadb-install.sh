#!/bin/bash

yum install mariadb-server -y
service mariadb restart
chkconfig mariadb on
