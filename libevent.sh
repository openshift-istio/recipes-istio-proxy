#!/bin/bash

set -e

VERSION=2.1.8-stable

if [ "${FETCH}" ]; then
  if [ ! -d "libevent-$VERSION" ]; then
    wget -O libevent-"$VERSION".tar.gz https://github.com/libevent/libevent/releases/download/release-"$VERSION"/libevent-"$VERSION".tar.gz
    tar xf libevent-"$VERSION".tar.gz
  fi
else
  cp -rf ${RPM_BUILD_DIR}/istio-proxy/libevent-"$VERSION" .

  cd libevent-"$VERSION"
  aclocal
  automake
  ./configure --prefix="$THIRDPARTY_BUILD" --enable-shared=no --disable-libevent-regress --disable-openssl
  make V=1 install
fi
