#!/bin/bash

set -e

VERSION=1.31.0

if [ "${FETCH}" ]; then
  if [ ! -d "nghttp2-$VERSION" ]; then
    wget -O nghttp2-"$VERSION".tar.gz https://github.com/nghttp2/nghttp2/releases/download/v"$VERSION"/nghttp2-"$VERSION".tar.gz
    tar xf nghttp2-"$VERSION".tar.gz
  fi
else
  cp -rf ${RPM_BUILD_DIR}/istio-proxy/nghttp2-"$VERSION" .

  cd nghttp2-"$VERSION"
  aclocal 
  automake
  ./configure --prefix="$THIRDPARTY_BUILD" --enable-shared=no --enable-lib-only
  make V=1 install
fi
