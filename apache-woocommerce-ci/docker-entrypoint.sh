#!/usr/bin/env bash

set -e

/wait-for-it.sh --timeout=5 wordpress_db:3306 --timeout=5 -- echo "mysql is loaded"
curl https://github.com/vindi/vindi-woocommerce-subscriptions/archive/develop.zip > vindi-woocommerce-subscriptions.zip
wp plugin install ./vindi-woocommerce-subscriptions.zip --activate --allow-root
rm vindi-woocommerce-subscriptions.zip
wp plugin update --all --allow-root

exec "$@"
