[![](https://images.microbadger.com/badges/image/keinos/php7-composer-alpine.svg)](https://microbadger.com/images/keinos/php7-composer-alpine "View image info on microbadger.com")
[![](https://img.shields.io/docker/cloud/automated/keinos/php7-composer-alpine)](https://hub.docker.com/r/keinos/php7-composer-alpine "Docker Cloud Automated build")
[![](https://img.shields.io/docker/cloud/build/keinos/php7-composer-alpine)](https://hub.docker.com/r/keinos/php7-composer-alpine/builds "Docker Cloud Build Status")

# Dockerfile of PHP7 with Composer installed on Alpine

```bash
docker pull keinos/php7-composer-alpine:latest
```

## Image Info

- Source: https://github.com/KEINOS/Dockerfile_of_PHP7-Composer-Alpine @ GitHub
- Image: https://hub.docker.com/r/keinos/php7-composer-alpine @ Docker Hub
- Base Image: [keinos/alpine:latest](https://hub.docker.com/r/keinos/alpine)

## Sample Usage

```shellsession
$ docker run --rm -it keinos/php7-composer-alpine:latest /bin/sh
/ # composer --version
Composer version 1.9.0 2019-08-02 20:55:32
/ #
/ # composer diagnose
Checking platform settings: OK
Checking git settings: OK
Checking http connectivity to packagist: OK
Checking https connectivity to packagist: OK
Checking github.com rate limit: OK
Checking disk free space: OK
Checking pubkeys:
Tags Public Key Fingerprint: 57815BA2 7E54DC31 7ECC7CC5 573090D0  87719BA6 8F3BB723 4E5D42D0 84A14642
Dev Public Key Fingerprint: 4AC45767 E5EC2265 2F0C1167 CBBB8A2B  0C708369 153E328C AD90147D AFE50952
OK
Checking composer version: OK
Composer version: 1.9.0
PHP version: 7.3.9
PHP binary path: /usr/bin/php7
/ #
/ # exit
$
```

```shellsession
$ docker run --rm -it keinos/php7-composer-alpine:latest /bin/sh
/ # whoami
root
/ #
/ # arch
x86_64
/ #
/ # # Loaded PHP Extensions
/ # php -r '$list=get_loaded_extensions();sort($list, SORT_NATURAL | SORT_FLAG_CASE); print_r($list);'
Array
(
    [0] => Core
    [1] => date
    [2] => filter
    [3] => hash
    [4] => json
    [5] => libxml
    [6] => mbstring
    [7] => openssl
    [8] => pcre
    [9] => Phar
    [10] => readline
    [11] => Reflection
    [12] => SPL
    [13] => standard
    [14] => zlib
)
```
