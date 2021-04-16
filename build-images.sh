#!/bin/bash

# Tor relay image builder
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

################################################################################
# Usage example: ./build-arch-images.sh 0.4.5.7 linux armhf
#
# tor version - Must be availible on https://dist.torproject.org/
# arch - Architecture (amd64, armhf, arm64...)
################################################################################

VARIANTS=(tor-relay ) # tor-relay-arm)
CURRENT_DIR=$(pwd)

help () {
  printf "
Usage example: ./build-images.sh 0.4.5.7 armhf

tor version - Must be availible on https://dist.torproject.org/ (0.4.5.7, 0.4.5.7-alpha)
arch - Architecture (amd64, armhf, arm64...)
";
}

if (( $# != 2 )); then
    >&2 echo "Illegal number of parameters";
    help;
    exit 1;
fi
TOR_VERSION="$1"
arch="$2"



for variant in ${VARIANTS[@]}
  do
    cd $CURRENT_DIR/$variant
    docker buildx build --load --tag scratchcat1/$variant:$TOR_VERSION ./
    # docker tag scratchcat1/$variant:$arch \
    #     scratchcat1/$variant:$TOR_VERSION\_$arch
  done
  
