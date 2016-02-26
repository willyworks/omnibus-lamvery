#
# Copyright 2013-2015 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "lambda-python"
default_version "2.7.9"

dependency "ncurses"
dependency "zlib"
dependency "openssl"
dependency "bzip2"

version("2.7.9") { source md5: "5eebcaa0030dc4061156d3429657fb83" }

source url: "https://python.org/ftp/python/#{version}/Python-#{version}.tgz"

relative_path "Python-#{version}"

build do
  env = {
    "CFLAGS" => "-I#{install_dir}/embedded/include -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv",
    "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib",
  }

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --enable-ipv6" \
          " --enable-shared" \
          " --enable-unicode=ucs4" \
          " --with-dbmliborder=gdbm:ndbm:bdb" \
          " --with-system-expat" \
          " --with-system-ffi" \
          " --with-dtrace" \
          " --with-tapset-install-dir=#{install_dir}/embedded/share/systemtap/tapset" \
          " --with-valgrind", env: env

  make env: env
  make "install", env: env

  # There exists no configure flag to tell Python to not compile readline
  delete "#{install_dir}/embedded/lib/python2.7/lib-dynload/readline.*"

  # Remove unused extension which is known to make healthchecks fail on CentOS 6
  delete "#{install_dir}/embedded/lib/python2.7/lib-dynload/_bsddb.*"
end
