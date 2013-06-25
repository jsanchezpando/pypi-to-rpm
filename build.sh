#!/bin/bash

ENVS=(2.6 2.7)
PACKAGES=(psycopg2)

build() {
  pip install pypy2rpm
  pypi2rpm.py $1
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

for e in ${ENVS[@]}; do
  setupenv ${e}
  for p in ${PACKAGES[@]}; do
    build ${p}
  done
  cleanenv
done

