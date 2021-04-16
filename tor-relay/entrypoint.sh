#!/bin/bash

# Tor relay entrypoint
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

CONF_FILE=/home/tor/torrc

if [ "$(whoami)" == "root" ]; then
  # Fix if the container is launched with the root (host) user
  if [ $HOST_UID -eq 0 ]; then
    HOST_UID=1000
  fi

  adduser -s /bin/bash -u $HOST_UID tor 2> /dev/null

  if [ $? -eq 0 ]; then
    chown -R tor:tor "$CONF_FILE"
    chown -R tor:tor /home/tor
  fi

  su -c "/entrypoint.sh $1" - tor
  exit
fi

cat $CONF_FILE || { echo "No torrc found, please attach the file using a docker volume"; exit 1; }

exec /usr/local/bin/tor -f ~/torrc
