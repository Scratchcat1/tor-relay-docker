#!/bin/bash

# Tor source verification script
# Copyright (C) 2022-2022 Connor Holloway <root_pfad@protonmail.com>
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

if [ -f $TOR_TARBALL_NAME.asc ]; then
    echo "Detected older style package verification (tarball + asc)"
    TOR_TARBALL_ASC="$TOR_TARBALL_NAME.asc"
    echo $(sha256sum $TOR_TARBALL_NAME)
    echo $(sha256sum $TOR_TARBALL_ASC)
    gpgv --keyring ./tor.keyring $TOR_TARBALL_ASC $TOR_TARBALL_NAME
else
    echo "Detected newer style package verification (sha256sum + sha256sum.asc)"
    sha256sum -c *.sha256sum
    gpgv --keyring ./tor.keyring "$TOR_TARBALL_NAME.sha256sum.asc" "$TOR_TARBALL_NAME.sha256sum"
fi