#!/bin/sh
# =============================================================================
#  Installs PHP Composer and tests work
# =============================================================================
echo '=============================='
echo ' Installing PHP Composer'
echo '=============================='

path_file_setup_composer='/composer-setup.php'
path_dir_current=$(pwd)

# Clean Up files on exit
function cleanUpFiles(){
    echo "- Removing file: ${path_file_setup_composer}"
    rm -f ${path_file_setup_composer:-/composer-setup.php}
}
trap cleanUPFiles EXIT INT QUIT KILL TERM HUP

# Verify hash value of the signature file
echo -n '- Verifing installer signature: '
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', '${path_file_setup_composer}');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', '${path_file_setup_composer}');")"
if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
    >&2 echo 'ERROR: Invalid installer signature'
    exit 1
fi
echo 'OK'

echo '- Setup composer:'
php $path_file_setup_composer
if [ $? -ne 0 ]; then
    echo 'ERROR: Can not install composer.'
    exit 1
fi

echo -n '- Moving composer to env path: '
mv composer.phar /usr/bin/composer && \
composer --version
if [ $? -ne 0 ]; then
    echo 'ERROR: Can not run composer.'
    exit 1
fi
echo 'OK'

echo '=============================='
echo ' Running Composer diagnose'
echo '=============================='
composer diagnose

echo '=============================='
echo ' Running Hello-World for test'
echo '=============================='

name_file_sample='sample.php'
path_dir_sample="${path_dir_current}/sample"
path_file_sample="${path_dir_sample}/${name_file_sample}"

mkdir $path_dir_sample && \
cd $path_dir_sample && \
composer init --quiet --name sample/hello-world --require rivsen/hello-world:dev-master && \
composer install

cat << 'SCRIPTSOURCE' > $path_file_sample
<?php
require_once "vendor/autoload.php";

$hello = new Rivsen\Demo\Hello();
echo $hello->hello(), PHP_EOL;
exit(0);

SCRIPTSOURCE

php $path_file_sample && \
rm -rf $path_file_sample
