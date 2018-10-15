#!/usr/bin/env bash

set -e

/wait-for-it.sh --timeout=5 wordpress_db:3306 --timeout=5 -- echo "mysql is loaded"
wget https://github.com/vindi/vindi-woocommerce-subscriptions/archive/develop.zip
wp plugin install ./develop.zip --activate --allow-root
rm develop.zip
wp plugin update --all --allow-root

exec "$@"
