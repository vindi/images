#!/usr/bin/env bash

set -e

git pull
composer update

exec "$@"
