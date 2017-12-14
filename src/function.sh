#!/bin/sh

function ex () {
  input="a b c";

  print "$ echo \"$input\" "" | $1 \n=> "
  echo $input | eval $1; echo;
}

function ex_input() {
  printf "$ echo \"$1\" "" | $2 \n=> "
  echo $1 | eval $2; echo;
}

function ex_direct() {
  printf "$ $1\n=> "
  eval $1; echo;
}

function section() {
  echo "■ Section: $1\n"
}
function memo() {
  echo "※ $1"
}
function important() {
  echo "[IMPORTANT] $1"
}
function caseof() {
  # echo "[$1]"
  echo "* $1"
}