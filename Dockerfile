# Dockerfile of PHP composer
# ==========================
FROM keinos/php7-alpine:latest

# Install Requirements
RUN apk --no-cache add \
# Requirement for downloading Composer's installer: composer-setup.sh
      php-openssl \
# Requirement of composer-setup.sh to run
      php-json \
      php-phar \
# Requirement of composer command to download packages
      git && \
      php --version

# Install composer
COPY ./install-composer.sh /install-composer.sh
RUN /install-composer.sh && \
    rm /install-composer.sh
