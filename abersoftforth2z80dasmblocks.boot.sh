#!/bin/sh
# abersoftforth2z80dasmblocks.boot.sh
# 2015-05-30

rm -f ./abersoftforth2z80dasmblocks_printout.txt
fuse \
	--machine 128 \
	--no-divide \
  --tape ./abersoftforth2z80dasmblocks_compiling.tap \
  --printer \
  --textfile ./abersoftforth2z80dasmblocks_printout.txt \
	$* \
	&

