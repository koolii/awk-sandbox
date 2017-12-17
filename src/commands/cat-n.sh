# pattern 1
# cat README.md | awk '{print NR, $0}'
# pattern 2
awk '{print NR, $0}' README.md