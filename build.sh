#!/bin/bash

ENVS=(2.6 2.7)
PACKAGES=(cx_Oracle psycopg2)
DESTDIR="./BUILD"
PREFIX=$(pwd)

if [[ -n $1 ]]; then
  idx=$(( ${#PACKAGES[@]} - 1 ))
  for a in $@; do
    idx=$((idx + 1))
    PACKAGES[$idx]=$a
  done
fi

build() {
  pypi2rpm.py --dist-dir ${PREFIX}/${DESTDIR} $1
}

setupenv() {
  virtualenv venv -p python$1
  . venv/bin/activate
  pip install pypi2rpm
}

cleanenv() {
  deactivate
  rm -rf venv
}

[[ -d ${DESTDIR} ]] || mkdir -p ${DESTDIR}

for e in ${ENVS[@]}; do
  setupenv ${e}
  for p in ${PACKAGES[@]}; do
    build ${p}
  done
  cleanenv
done

