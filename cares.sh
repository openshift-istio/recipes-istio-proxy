#!/bin/bash

set -e

VERSION=cares-1_13_0

# cares is fussy over whether -D appears inside CFLAGS vs. CPPFLAGS, oss-fuzz
# sets CFLAGS with -D, so we need to impedance match here.
CPPFLAGS="$(for f in $CXXFLAGS; do if [[ $f =~ -D.* ]]; then echo $f; fi; done)"
CFLAGS="$(for f in $CXXFLAGS; do if [[ ! $f =~ -D.* ]]; then echo $f; fi; done)"

if [ "${FETCH}" ]; then
  if [ ! -d "c-ares-$VERSION" ]; then
    wget -O c-ares-"$VERSION".tar.gz https://github.com/c-ares/c-ares/archive/"$VERSION".tar.gz
    tar xf c-ares-"$VERSION".tar.gz
  fi
else
  cp -rf ${RPM_BUILD_DIR}/istio-proxy/c-ares-"$VERSION" .

  cd c-ares-"$VERSION"
  aclocal
  ./buildconf
  ./configure --prefix="$THIRDPARTY_BUILD" --enable-shared=no --enable-lib-only \
    --enable-debug --enable-optimize
  make V=1 install
fi
