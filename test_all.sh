#!/bin/bash

for f in $( ls euler_*.nim ); do
  echo "Testing ${f::-4}"
  ./test_program.sh "${f::-4}"
  echo ""
done
