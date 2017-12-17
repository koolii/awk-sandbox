#!/bin/sh

. src/function.sh

caseof 'headコマンドのSIGPIPEによるエラー'
seq 1 10000 | head > /dev/null
echo ${PIPESTATUS[@]}

caseof 'AWKによるSIGPIPEの回避'
seq 1 10000 | awk 'NR <= 10 {print $0}' > /dev/null
echo ${PIPESTATUS[@]}