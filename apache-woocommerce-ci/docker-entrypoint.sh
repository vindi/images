#!/usr/bin/env bash

set -e

git pull

exec "$@"
