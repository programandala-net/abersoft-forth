#!/bin/sh
# abersoftforth2branches.boot.vim-output.sh
# 2015-05-30

rm -f ./tidy_branches.vim
fuse \
	--machine 128 \
	--no-divide \
  --tape ./abersoftforth2branches_compiling.tap \
  --printer \
  --textfile ./tidy_branches.vim \
	$* \
	&

