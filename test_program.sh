#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)



if [[ -e $1 ]]; then
  rm $1
fi
script -q -c "nim c $1.nim" compile.tmp > /dev/null

if [[ ! -e $1 ]]; then
  printf "${RED}Compilation failed${NC}\n"
  cat compile.tmp
  exit
else
  if [[ "$2" != "DEBUG" ]]; then
    nim c -d:release $1.nim &> /dev/null
  fi
fi

if [[ -e compile.tmp ]]; then
  rm compile.tmp
fi

COLS=50

{ time ./$1 < $1.in &> out.tmp ; } 2> time.tmp
if [[ $( cat $1.out ) == $( cat out.tmp ) ]]; then
  TIME=$( cat time.tmp | grep real | grep -oE "[0-9.]+m[0-9.]+s" )
  SPACES=$( expr $COLS - ${#1} )
  printf "$1%${SPACES}s${GREEN}Passed${NC} in ${TIME}\n"
else
  printf "$1%${SPACES}s${RED}Failed${NC}\n"
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
if [[ -e time.tmp ]]; then
  rm time.tmp
fi
