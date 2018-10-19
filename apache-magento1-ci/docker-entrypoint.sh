#!/usr/bin/env bash

set -e

cd /var/www/html/
modgit update vindi

cd /var/www/html/app/code/community/Vindi/Subscription/tests
composer update --no-dev --no-scripts


exec "$@"
