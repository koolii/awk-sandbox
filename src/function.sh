#!/bin/sh

function ex () {
  input="a b c";

  print "$ echo \"$input\" "" | $1 \n=> "
  echo $input | eval $1; echo;
}

function exWithInput() {
  printf "$ echo \"$input\" "" | $1 \n=> "
  echo $1 | eval $2; echo;
}

function section() {
  echo "■ Section: $1"
}
function memo() {
  echo "※ $1"
}
function important() {
  echo "[IMPORTANT] $1"
}
function caseof() {
  # echo "[$1]"
  echo "$1"
}