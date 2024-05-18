#!/bin/bash

# Set the project name and author
PROJECT_NAME=$1
AUTHOR=$2

# Check if the project name was provided
if [ -z "$PROJECT_NAME" ]; then
  echo "Please provide the project name"
  exit 1
fi

# Create a new Laravel project
composer create-project --prefer-dist laravel/laravel $PROJECT_NAME

# Set the author in the composer.json file
sed -i "s|^author:.*$|author: ${AUTHOR},|" $PROJECT_NAME/composer.json

# Install dependencies
cd $PROJECT_NAME && composer install

# Create a new .env file
cp .env.example $PROJECT_NAME/.env

# Set the timezone and locale in the .env file
sed -i "s|^TIME_ZONE=.*$|TIME_ZONE=${TZ}|" $PROJECT_NAME/.env
sed -i "s|^LOCALE=.*$|LOCALE=${LOCALE}|" $PROJECT_NAME/.env

echo "Laravel project created successfully!"