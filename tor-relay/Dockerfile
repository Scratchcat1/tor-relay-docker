# Tor relay from source
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

FROM alpine:3.12.0 as builder
LABEL maintainer "Connor Holloway" <root_pfad@protonmail.com>

################################################
# TOR RELAY
################################################

ARG TOR_VERSION=0.4.5.7

ENV TOR_TARBALL_NAME tor-$TOR_VERSION.tar.gz
ENV TOR_TARBALL_LINK https://dist.torproject.org/$TOR_TARBALL_NAME
ENV TOR_TARBALL_ASC $TOR_TARBALL_NAME.asc
ENV TOR_GPG_KEY 0x6AFEE6D49E92B601

RUN \
  apk --no-cache add \
    wget \
    make \
    gcc \
    libevent-dev \
    libressl-dev \
    gnupg \
    tar \
    musl-dev \
    zlib-dev \
    bash \
    libressl

ADD build-tor.sh build-tor.sh
RUN chmod +rx build-tor.sh
RUN bash build-tor.sh
# RUN ls -lhaR /artifacts && exit 1


# RUN apk del \
#     wget \
#     make \
#     gcc \
#     libevent-dev \
#     libressl-dev \
#     gnupg \
#     tar \
#     musl-dev \
#     zlib-dev

FROM alpine:3.12.0
LABEL maintainer "Connor Holloway" <root_pfad@protonmail.com>

RUN apk --no-cache add \
  libevent \
  libressl \
  bash \
  libgcc

COPY --from=builder /artifacts/ /
# RUN ls -lhaR /usr && exit 1

COPY entrypoint.sh /
RUN chmod +rx entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
