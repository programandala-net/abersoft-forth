#!/bin/sh
# abersoftforth2branches.boot.symbols-output.sh
# 2015-05-30

rm -f ./z80dasm_symbols.branches.vim
fuse \
	--machine 128 \
	--no-divide \
  --tape ./abersoftforth2branches_compiling.tap \
  --printer \
  --textfile ./z80dasm_symbols.branches.vim \
	$* \
	&

