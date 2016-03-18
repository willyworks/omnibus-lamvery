#
# Copyright 2016 YOUR NAME
#
# All Rights Reserved.
#

name "lamvery"
maintainer "Willyworks"
homepage "https://willy.works"

lamvery_version = ENV['BUILD_VERSION'].split('-')

# Defaults to C:/lamvery on Windows
# and /opt/lamvery on all other platforms
install_dir "#{default_root}/#{name}"
build_version lamvery_version[0]
build_iteration lamvery_version[1]

# Creates required build directories
dependency "preparation"

description "Lamvery #{lamvery_version[0]} with Python 2.7.9"
dependency "python"
dependency "pypi"
override :lamvery, version: lamvery_version[0]
dependency "lamvery"
dependency "virtualenv"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
