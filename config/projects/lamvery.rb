#
# Copyright 2016 YOUR NAME
#
# All Rights Reserved.
#

name "lamvery"
maintainer "Willyworks"
homepage "https://willy.works"

require 'rexml/document'
require 'open-uri'
doc = REXML::Document.new(open('https://pypi.python.org/pypi?:action=doap&name=lamvery').read)
lamvery_version = doc.elements['release']['Version']['revision'].to_s

# Defaults to C:/lamvery on Windows
# and /opt/lamvery on all other platforms
install_dir "#{default_root}/#{name}"

build_version lamvery_version
build_iteration 1

# Creates required build directories
dependency "preparation"

description "Lamvery #{lamvery_version} with Python 2.7.9"

dependency "lambda-python"
override :pip, version: "8.0.3",
  source: {
  md5: "8f000fc101e47f4f199fa29df1e0b0df"
}
dependency "pip"
override :lamvery, version: lamvery_version
dependency "lamvery"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
