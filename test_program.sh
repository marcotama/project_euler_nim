#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color



if [[ -e $1 ]]; then
  rm $1
fi
script -q -c "nim c $1.nim" compile.tmp > /dev/null

if [[ ! -e $1 ]]; then
  printf "${RED}Compilation failed${NC}\n"
  cat compile.tmp
  exit
#else
  #nim c -d:release $1.nim &> /dev/null
fi

if [[ -e compile.tmp ]]; then
  rm compile.tmp
fi



{ time ./$1 < $1.in &> out.tmp ; } 2> time.tmp
if [[ $( cat $1.out ) == $( cat out.tmp ) ]]; then
  printf "${GREEN}Test passed${NC}\n"
  echo "Elapsed time: " $( cat time.tmp | grep real | grep -oE "[0-9.]+m[0-9.]+s" )
else
  printf "${RED}Test failed${NC}\n"
  echo ""
  echo "Input:"
  cat $1.in
  echo ""
  echo "Expected output:"
  cat $1.out
  echo ""
  echo "Program output:"
  cat out.tmp
fi

if [[ -e out.tmp ]]; then
  rm out.tmp
fi
if [[ -e outtimetmp ]]; then
  rm time.tmp
fi
