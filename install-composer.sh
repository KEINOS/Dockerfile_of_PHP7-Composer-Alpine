#!/bin/sh
# =============================================================================
#  Installs PHP Composer and tests work
# =============================================================================
echo '=============================='
echo ' Installing PHP Composer'
echo '=============================='

# Verify hash value of the signature file
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

echo '- Setup composer:'
php composer-setup.php
if [ $? -ne 0 ]; then
    echo 'ERROR: Can not install composer.'
    rm composer-setup.php
    exit 1
fi

echo '- Moving composer to env path:'
mv composer.phar /usr/bin/composer && \
composer --version
if [ $? -ne 0 ]; then
    echo 'ERROR: Can not run composer.'
    rm composer-setup.php
    exit 1
fi

echo '=============================='
echo ' Running Composer diagnose'
echo '=============================='
composer diagnose

echo '=============================='
echo ' Running Hello-World for test'
echo '=============================='
mkdir ~/sample && \
cd ~/sample && \
composer init --quiet --name sample/hello-world --require rivsen/hello-world:dev-master && \
composer install

cat << 'SCRIPTSOURCE' > sample.php
<?php
require_once "vendor/autoload.php";

$hello = new Rivsen\Demo\Hello();
echo $hello->hello(), PHP_EOL;
exit(0);

SCRIPTSOURCE

php sample.php && \
rm -rf ~/sample && \
rm /composer-setup.php
