#!/usr/bin/env bash

set -ex

. /root/load-omnibus-toolchain.sh
bundle install --binstubs --without development

bin/omnibus build lamvery
