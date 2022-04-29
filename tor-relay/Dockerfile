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

FROM alpine:3.15.4 as builder
LABEL maintainer="Connor Holloway <root_pfad@protonmail.com>"

################################################
# TOR RELAY
################################################

ARG TOR_VERSION=0.4.7.7

ENV TOR_TARBALL_NAME tor-$TOR_VERSION.tar.gz
ENV TOR_TARBALL_LINK https://dist.torproject.org/$TOR_TARBALL_NAME
# Keys from: https://support.torproject.org/little-t-tor/verify-little-t-tor/
ENV TOR_GPG_KEY "0x514102454D0A87DB0767A1EBBE6A0531C18A9179 0xB74417EDDF22AC9F9E90F49142E86A2A11F48D36 0x2133BC600AB133E1D826D173FE43009C4607B1FB"

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

RUN gpg --keyserver keyserver.ubuntu.com --recv-keys $TOR_GPG_KEY
RUN gpg --output ./tor.keyring --export $TOR_GPG_KEY

RUN mkdir /artifacts
RUN wget $TOR_TARBALL_LINK -O ${TOR_TARBALL_NAME}
# Older packages just have an asc file, newer ones have sha256sum + sha256sum.asc files
RUN wget $TOR_TARBALL_LINK.asc || (wget $TOR_TARBALL_LINK.sha256sum && wget $TOR_TARBALL_LINK.sha256sum.asc)

ADD verify-source.sh verify-source.sh
RUN chmod +rx verify-source.sh
RUN bash verify-source.sh

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

FROM alpine:3.15.4
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
