#!/bin/sh
# abersoftforth2nfa4vim.boot.sh
# 2015-05-31

rm -f ./abersoftforth2nfa4vim_printout.txt
fuse \
	--machine 128 \
	--no-divide \
  --tape ./abersoftforth2nfa4vim_compiling.tap \
  --printer \
  --textfile ./abersoftforth2nfa4vim_printout.txt \
	$* \
	&

