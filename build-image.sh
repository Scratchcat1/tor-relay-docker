#!/bin/bash

# Tor relay image builder
# Copyright (C) 2018 Rodrigo Martínez <dev@brunneis.com>
# Copyright (C) 2021-2022 Connor Holloway <root_pfad@protonmail.com>
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

################################################################################
# Usage example: ./build-image.sh 0.4.5.7
#
# tor version - Must be availible on https://dist.torproject.org/
################################################################################

CURRENT_DIR=$(pwd)

help () {
  printf "
Usage example: ./build-image.sh 0.4.5.7

tor version - Must be availible on https://dist.torproject.org/ (0.4.5.7, 0.4.5.7-alpha)
";
}

if (( $# != 1 )); then
    >&2 echo "Illegal number of parameters";
    help;
    exit 1;
fi
TOR_VERSION="$1"
VARIANTS=(tor-relay ) # tor-relay-arm)

for variant in ${VARIANTS[@]}
  do
    cd $CURRENT_DIR/$variant
    docker buildx build --load --build-arg TOR_VERSION=$TOR_VERSION --tag scratchcat1/$variant:$TOR_VERSION ./
  done
