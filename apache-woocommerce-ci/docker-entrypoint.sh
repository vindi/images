#!/usr/bin/env bash

set -e

git pull
composer update
#/wait-for-it.sh --timeout=10 wordpress_db:3306 --timeout=10 -- echo "mysql is loaded"
#wp plugin update --all --allow-root
#wp plugin activate vindi-woocommerce-subscriptions --allow-root

exec "$@"
