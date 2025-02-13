#!/bin/bash

# Tor relay entrypoint
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

set -e

CONF_FILE=/home/tor/torrc

if [[ $UID -eq 0 ]]; then
  # Fix if the container is launched with the root (host) user
  if [[ $HOST_UID -eq 0 ]]; then
    echo "HOST_UID not set or 0, defaulting to 1000";
    HOST_UID=1000;
  fi

  echo "Creating the tor user with uid: $HOST_UID";
  adduser --disabled-password -s /bin/bash -u $HOST_UID tor 2> /dev/null

  if [[ $? -eq 0 ]]; then
    chown -R tor:tor "$CONF_FILE"
    chown -R tor:tor /home/tor
  fi

  su -c "/entrypoint.sh $1" - tor
  exit
fi

cat $CONF_FILE || { echo "No torrc found, please attach the file using a docker volume"; exit 1; }
echo "Running as uid: $UID with home: $HOME";
exec /usr/local/bin/tor -f "$CONF_FILE"
