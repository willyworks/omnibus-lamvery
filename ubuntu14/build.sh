#!/usr/bin/env bash

set -ex

source /root/load-omnibus-toolchain.sh
bundle install --binstubs --without development

bin/omnibus build lamvery
