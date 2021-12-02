#!/bin/bash

# Mysql манипуляции
mysql -h db -P 3306 -u root --password=admin --execute "CREATE DATABASE dostavim;"
mysql -h db -P 3306 -u root --password=admin --database=dostavim </CREATE.sql

# Сиды и приложение
java -jar /seeds.jar
java -jar /app.jar