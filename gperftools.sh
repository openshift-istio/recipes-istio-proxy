#!/bin/bash

set -e

VERSION=2.6.3

if [ "${FETCH}" ]; then
  if [ ! -d "gperftools-$VERSION" ]; then
    wget -O gperftools-"$VERSION".tar.gz https://github.com/gperftools/gperftools/releases/download/gperftools-"$VERSION"/gperftools-"$VERSION".tar.gz
    tar xf gperftools-"$VERSION".tar.gz
  fi
else
  cp -rf ${RPM_BUILD_DIR}/istio-proxy/gperftools-"$VERSION" .

  cd gperftools-"$VERSION"
  aclocal
  automake
  LDFLAGS="-lpthread" ./configure --prefix="$THIRDPARTY_BUILD" --enable-shared=no --enable-frame-pointers --disable-libunwind
  make V=1 install
fi
