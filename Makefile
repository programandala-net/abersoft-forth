# Abersoft Forth disassembled Makefile

# Copyright (C) 2015 By Marcos Cruz (programandala.net)

# This file is part of
# Abersoft Forth disassembled
# http://programandala.net/en.program.abersoft_forth.html

# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and
# this notice are preserved.  This file is offered as-is, without any warranty.

################################################################
# Requirements

# Vim (by Bram Moolenaar)
# 	http://vim.org

# head, cat and sort (from the GNU coreutils)

# bas2tap (by Martijn van der Heide)
#   Utilities section of
#   http://worldofspectrum.org

# Pasmo (by Julián Albo)
#   http://pasmo.speccy.org/

# Afera (by Marcos Cruz)
# 	http://programandala.net/en.program.afera.html

# fsb (by Marcos Cruz)
# 	http://programandala.net/en.program.fsb.html

################################################################
# Change history

# See at the end of the file.

################################################################
# Config

MAKEFLAGS = --no-print-directory

.ONESHELL:

################################################################
# Main

all: \
	abersoft_forth.rebuilt.tap

tools: \
	abersoftforth2z80dasmblocks \
	abersoftforth2nfa4vim \
	abersoftforth2branches

.PHONY : clean
clean:
	rm -f \
		abersoft_forth.disassembled.z80s \
		abersoftforth2z80dasmblocks_compiling.tap \
		abersoftforth2z80dasmblocks_printout.tidy.txt \
		abersoftforth2nfa4vim_compiling.tap \
		abersoftforth2branches_compiling.tap

################################################################
# The z80dasm blocks file

# There are two z80dasm blocks files that must be combined into one, because
# z80dasm does not accept more than one such file as input.  One file,
# <abersoftforth2z80dasmblocks_printout.txt>, is created by
# AbersoftForth2z80dasmBlocks, a tool written in Abersoft Forth itself, and it
# must be post-processed in order to substitute the temporary names of all
# labels; the other file, <z80dasmblocks.custom.txt> is manually created and
# ready to be used.

# First, substitute the temporary label names in the raw printout produced by
# AbersoftForth2z80dasmBlocks.

# 2015-05-26: <word_labels.sed> doesn't translate labels with numeric suffixes,
# I don't understand why. I start using Vim instead of sed: it works as
# expected and faster.

abersoftforth2z80dasmblocks_printout.tidy.txt: \
	abersoftforth2z80dasmblocks_printout.txt \
	word_labels.z80dasm_blocks.vim
	vim -e -n -R \
		-S word_labels.z80dasm_blocks.vim \
		-c "saveas! abersoftforth2z80dasmblocks_printout.tidy.txt|q" \
		abersoftforth2z80dasmblocks_printout.txt 

# Second, combine both files into one.

z80dasm_blocks.txt: \
	abersoftforth2z80dasmblocks_printout.tidy.txt \
	z80dasm_blocks.custom.txt
	cat \
		abersoftforth2z80dasmblocks_printout.tidy.txt \
		z80dasm_blocks.custom.txt | \
	sort --field-separator=":" --key=2 > z80dasm_blocks.txt

################################################################
# The recreated Z80 source

# The original binary must be padded with zeroes, both at the start (because of
# the way Abersoft Forth stores some values at the start, before the actual
# loading address of the binary) and at the end (to prevent errors caused by
# patched words that use words that don't belong to the original system).

# XXX TODO check if the final padding is still necessary.

abersoft_forth.padded.bin: abersoft_forth.original.bin
	head --bytes=64 /dev/zero > abersoft_forth.padded.bin && \
	cat abersoft_forth.original.bin >> abersoft_forth.padded.bin && \
	head --bytes=1K /dev/zero >> abersoft_forth.padded.bin

# z80dasm creates a raw source, with a lot of temporary labels and debugging
# information.

abersoft_forth.disassembled.raw.z80s: \
	abersoft_forth.padded.bin \
	z80dasm_blocks.txt \
	z80dasm_symbols.z80s
	z80dasm \
		--origin=24064 \
		--address \
		--source \
		--labels \
		--block-def=z80dasm_blocks.txt \
		--sym-input=z80dasm_symbols.z80s \
		--output=abersoft_forth.disassembled.raw.z80s \
		abersoft_forth.padded.bin

# Some Vim programs tidy the raw source created by z80dasm and create the
# definitive one.

tidy_name_fields.vim: \
	abersoftforth2nfa4vim_printout.txt \
	word_labels.name_fields.vim
	vim -e -n -R \
		-S word_labels.name_fields.vim \
		-c "saveas! tidy_name_fields.vim|q" \
		abersoftforth2nfa4vim_printout.txt 

# The file <tidy_branches.vim>, created by <abersoftforth2branches.fsb>,
# must be converted to Unix format, else its commands will fail.
.PHONY: tidy_branches.vim
tidy_branches.vim:
	vim -e -c "set fileformat=unix|wq" tidy_branches.vim

tidy: \
	tidy_name_fields.vim \
	tidy_branches.vim \
	tidy_z80.vim

abersoft_forth.disassembled.z80s: \
	abersoft_forth.disassembled.raw.z80s \
 	tidy
	vim -e -n -R \
		-S tidy_z80.vim \
		-c "saveas! abersoft_forth.disassembled.z80s|q" \
		abersoft_forth.disassembled.raw.z80s

################################################################
# The rebuilt binary

# A new binary is rebuilt from the reconstructed Z80 source, to check
# everything works.

# The new basic loader.

abersoft_forth_loader.tap: abersoft_forth_loader.bas
	bas2tap -q -n -sAutoload -a1 -sForth \
		abersoft_forth_loader.bas  \
		abersoft_forth_loader.tap

# The new binary.

# A temporary name "forth.bin" is used because Pasmo does not have an option to
# choose the filename used in the TAP file header; it uses the name of the
# target file.

abersoft_forth.rebuilt.bin.tap: abersoft_forth.disassembled.z80s
	pasmo --tap \
		abersoft_forth.disassembled.z80s \
		forth.bin \
		abersoft_forth.rebuilt.symbols.z80s ; \
	mv forth.bin abersoft_forth.rebuilt.bin.tap

# The new complete TAP file, ready to be loaded by the emulator.

abersoft_forth.rebuilt.tap: \
	abersoft_forth_loader.tap \
	abersoft_forth.rebuilt.bin.tap
	cat abersoft_forth_loader.tap abersoft_forth.rebuilt.bin.tap > \
		abersoft_forth.rebuilt.tap \

################################################################
# The tools written in Abersoft Forth

%.tap: %.fsb
	fsb2abersoft16k $<

abersoftforth2z80dasmblocks: abersoftforth2z80dasmblocks_compiling.tap

abersoftforth2z80dasmblocks_compiling.tap: \
	abersoftforth2z80dasmblocks.tap \
	afera_for_disassembling.tap \
	patches.tap
	cat \
		abersoft_forth.original.tap \
		lib/loader.tap \
		afera_for_disassembling.tap \
		lib/dot-s.tap \
		lib/cswap.tap \
		lib/dump.tap \
		lib/recurse.tap \
		lib/decode.tap \
		lib/lowersys.tap \
		lib/bank.tap \
		lib/16kramdisks.tap \
		lib/upperc.tap \
		lib/uppers.tap \
		lib/caseins.tap \
		lib/move.tap \
		lib/flags.tap \
		lib/qexit.tap \
		lib/pick.tap \
		lib/strings.tap \
		lib/2r.tap \
		lib/csb.tap \
		lib/csb-256.tap \
		lib/s-plus.tap \
		patches.tap \
		abersoftforth2z80dasmblocks.tap \
		> abersoftforth2z80dasmblocks_compiling.tap ; \
	rm -f abersoftforth2z80dasmblocks.tap

abersoftforth2nfa4vim: abersoftforth2nfa4vim_compiling.tap

abersoftforth2nfa4vim_compiling.tap: \
	abersoftforth2nfa4vim.tap \
	patches.tap
	cat \
		abersoft_forth.original.tap \
		lib/loader.tap \
		lib/afera.tap \
		lib/dot-s.tap \
		lib/cswap.tap \
		lib/dump.tap \
		lib/recurse.tap \
		lib/decode.tap \
		lib/lowersys.tap \
		lib/bank.tap \
		lib/48kq.tap \
		lib/16kramdisks.tap \
		lib/upperc.tap \
		lib/uppers.tap \
		lib/caseins.tap \
		lib/unloop.tap \
		lib/move.tap \
		lib/flags.tap \
		lib/qexit.tap \
		lib/pick.tap \
		lib/strings.tap \
		lib/2r.tap \
		lib/csb.tap \
		lib/csb-256.tap \
		lib/s-plus.tap \
		patches.tap \
		abersoftforth2nfa4vim.tap \
		> abersoftforth2nfa4vim_compiling.tap ; \
	rm -f abersoftforth2nfa4vim.tap

abersoftforth2branches: abersoftforth2branches_compiling.tap

abersoftforth2branches_compiling.tap: \
	abersoftforth2branches.tap \
	afera_for_disassembling.tap \
	patches.tap
	cat \
		abersoft_forth.original.tap \
		lib/loader.tap \
		afera_for_disassembling.tap \
		lib/dot-s.tap \
		lib/cswap.tap \
		lib/dump.tap \
		lib/recurse.tap \
		lib/decode.tap \
		lib/lowersys.tap \
		lib/bank.tap \
		lib/48kq.tap \
		lib/16kramdisks.tap \
		lib/upperc.tap \
		lib/uppers.tap \
		lib/caseins.tap \
		lib/move.tap \
		lib/flags.tap \
		lib/qexit.tap \
		lib/pick.tap \
		lib/strings.tap \
		lib/2r.tap \
		lib/csb.tap \
		lib/csb-256.tap \
		lib/s-plus.tap \
		patches.tap \
		abersoftforth2branches.tap \
		> abersoftforth2branches_compiling.tap ; \
	rm -f abersoftforth2branches.tap

################################################################
# Backup

.PHONY: backup
backup:
	tar -czf backups/$$(date +%Y%m%d%H%M)_abersoft_forth_disassembled.tgz \
		Makefile \
		*.adoc \
		*.bas \
		*.fsb \
		*.sh \
		z80dasm_blocks.custom.txt \
		z80dasm_symbols.z80s \
		tidy_z80.vim \
		word_labels.*.vim \
		_ex/*

################################################################
# Change history

# 2015-05-13: Start.
#
# 2015-05-23: "dis" moved from the Afera library.
#
# 2015-05-24: Many changes and improvements.
#
# 2015-05-25: New method: the Abersoft Forth tool that creates the high-level
# disassembling is deprecated. A new similar tool is written that creates only
# the z80dasm blocks. With that information, the disassembler can do the whole
# job.
#
# 2015-05-26: First successful disassembling, reassembling and execution!
# General renaming of all files.
#
# 2015-05-30: Improvements and updates.
#
# 2015-05-31: New: backup recipe.
