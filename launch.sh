#!/bin/bash

# Tor relay launcher
# Copyright (C) 2017-2018 Rodrigo Martínez <dev@brunneis.com>
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
# Usage example: ./launch.sh scratchcat1/tor-relay:0.4.5.7 ./my_torrc
#
# arg1 - Docker image (required)
# arg2 - torrc path (required, must be the absolute path)
# arg3 - OR Port (default: 9001)
# arg4 - DIR Port (default: 9030)
# arg5 - Host UID. The UID tor will use inside the container (default: $UID)
################################################################################

help () {
  printf "
Usage example: ./launch.sh scratchcat1/tor-relay:0.4.5.7 ./my_torrc

arg1 - Docker image (required)
arg2 - torrc path (required)
arg3 - OR Port (default: 9001)
arg4 - DIR Port (default: 9030)
arg5 - Host UID. The UID tor will use inside the container (default: $UID)
";
}

if (( $# < 2 )); then
    >&2 echo "Illegal number of parameters (2 required)";
    help;
    exit 1;
fi

DOCKER_IMAGE=${1:-scratchcat1/tor-relay:latest}
TORRC_PATH=${2-}
OR_PORT_DOCKER=${3:-9001}
DIR_PORT=${4:-9030}
HOST_UID=${5-"$UID"}

docker run -i \
-p $OR_PORT_DOCKER:$OR_PORT_DOCKER \
-p $DIR_PORT:$DIR_PORT \
-e "HOST_UID=$HOST_UID" \
-v "$TORRC_PATH:/home/tor/torrc" \
-v $(pwd)/tor-data:/home/tor/.tor:Z \
--name tor-relay $DOCKER_IMAGE
