#!/bin/bash

# Tor relay image pusher
# Copyright (C) 2018 Rodrigo Martínez <dev@brunneis.com>
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
# Usage example: ./push-arch-images.sh armhf arm64
#
# args - Architectures
################################################################################

echo "Not yet working"
exit 1;

ARCHS=($@)
VARIANTS=(tor-relay tor-relay-arm)

for arch in ${ARCHS[@]}
  do
    for variant in ${VARIANTS[@]}
      do
        docker push brunneis/$variant:$arch
        docker push brunneis/$variant:$TOR_VERSION\_$arch
      done
  done
