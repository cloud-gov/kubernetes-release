#!/bin/sh

set -e
set -x

VERSION=$1
if [ -z "${VERSION}" ]; then
  echo 'Usage: ./update-kubernetes.sh <version>'
  exit 1
fi

mkdir tmp
pushd tmp
  curl -O -L https://github.com/kubernetes/kubernetes/releases/download/${VERSION}/kubernetes.tar.gz
  tar xf kubernetes.tar.gz
popd

bosh add blob tmp/kubernetes/server/kubernetes-server-linux-amd64.tar.gz kubernetes/
bosh -n upload blobs