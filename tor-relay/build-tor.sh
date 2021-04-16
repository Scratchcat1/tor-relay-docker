#!/bin/bash

# Tor build script
# Copyright (C) 2017-2018 Rodrigo Martínez <dev@brunneis.com>
# Copyright (C) 2021-2021 Connor Holloway <root_pfad@protonmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e

COUNT_CORES=`grep -c ^processor /proc/cpuinfo`
echo "Will use $COUNT_CORES parallel jobs to build Tor"

mkdir /artifacts
wget $TOR_TARBALL_LINK
wget $TOR_TARBALL_LINK.asc
gpg --keyserver pool.sks-keyservers.net --recv-keys $TOR_GPG_KEY
gpg --verify $TOR_TARBALL_NAME.asc
tar xvf $TOR_TARBALL_NAME
cd tor-$TOR_VERSION
./configure \
    --build=$(uname -m)-alpine-linux-musl \
    --host=$(uname -m)-alpine-linux-musl \
    --target=$(uname -m)-alpine-linux-musl
make -j$COUNT_CORES
make install DESTDIR=/artifacts
cd ..
rm -r tor-$TOR_VERSION
rm $TOR_TARBALL_NAME
rm $TOR_TARBALL_NAME.asc