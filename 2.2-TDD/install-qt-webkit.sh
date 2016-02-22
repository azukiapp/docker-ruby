#!/bin/bash
# ==============================================================================
# WEBKIT & QT
# ==============================================================================

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
else
  apt-get update
  apt-get -yq install libqtwebkit-dev
  apt-get -yq install qt4-qmake
  apt-get clean -qq
fi
