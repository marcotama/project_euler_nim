#!/bin/bash

for f in $( ls euler_*.nim ); do
  ./test_program.sh "${f::-4}"
done
