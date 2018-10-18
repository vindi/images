#!/usr/bin/env bash

set -e

/wait-for-it.sh --timeout=5 wordpress_db:3306 --timeout=5 -- echo "mysql is loaded"
wp plugin update --all --allow-root
wp plugin activate vindi-woocommerce-subscriptions --allow-root

exec "$@"
