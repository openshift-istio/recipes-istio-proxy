#!/bin/bash

set -e

VERSION=1.2.11

if [ "${FETCH}" ]; then
  if [ ! -d "zlib-$VERSION" ]; then
    wget -O zlib-"$VERSION".tar.gz https://github.com/madler/zlib/archive/v"$VERSION".tar.gz
    tar xf zlib-"$VERSION".tar.gz
  fi
else
  cp -rf ${RPM_BUILD_DIR}/istio-proxy/zlib-"$VERSION" .

  cd zlib-"$VERSION"
  ./configure --prefix="$THIRDPARTY_BUILD"
  make V=1 install
fi
