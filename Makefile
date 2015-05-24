# Abersoft Forth Makefile

# By Marcos Cruz (programandala.net)
# http://programandala.net/en.program.dzx-forth.html

################################################################
# Requirements

# Pasmo (by Julián Albo)
#   http://pasmo.speccy.org/

# tap2dsk from Taptools (by John Elliott)
#   http://www.seasip.info/ZX/unix.html

# bin2code (by MetalBrain)
#   http://metalbrain.speccy.org/link-eng.htm

# bas2tap (by Martijn van der Heide)
#   Utilities section of
#   http://worldofspectrum.org

################################################################
# Change history

# See at the end of the file.

################################################################
# TODO


################################################################
# Config

# VPATH = src:doc:bin
MAKEFLAGS = --no-print-directory

.ONESHELL:

################################################################
# Main

.PHONY: all
all: dis_compiling.tap

################################################################
# XXX TODO

abersoft_forth_z80dasm_block-def_dis.txt: dis_printout.txt
	sed -e XXX dis_printout.txt | \
	sort > /tmp/dis_printout_tidied_0.txt && \
	grep " ; \[Z80DASM ZONE]" /tmp/dis_printout_tidied_0.txt > \
		abersoft_forth_z80dasm_block-def_dis.txt
	

################################################################
# XXX TODO

abersoft_forth.z80s: \
	abersoft_forth_z80dasm_block-def_dis.txt \
	abersoft_forth_z80dasm_block-def.txt \
	abersoft_forth_z80dasm_sym-input.z80s
	z80dasm \
		--origin=24064 \
		--address \
		--labels \
		--block-def=abersoft_forth_z80dasm_block-def_dis.txt \
		--block-def=abersoft_forth_z80dasm_block-def.txt \
		--sym-input=abersoft_forth_z80dasm_sym-input.z80s \
		--output=abersoft_forth.z80s \
		abersoft_forth.bin

################################################################
# dis

%.tap: %.fsb
	fsb2abersoft16k $<

dis_compiling.tap: dis.tap
	cat \
		lib/afera/sys/abersoft_forth_afera_tools_inc.tap \
		lib/afera/tap/lowersys.tap \
		lib/afera/tap/bank.tap \
		lib/afera/tap/16kramdisks.tap \
		lib/afera/tap/upperc.tap \
		lib/afera/tap/uppers.tap \
		lib/afera/tap/caseins.tap \
		lib/afera/tap/move.tap \
		lib/afera/tap/flags.tap \
		lib/afera/tap/qexit.tap \
		lib/afera/tap/pick.tap \
		lib/afera/tap/strings.tap \
		lib/afera/tap/2r.tap \
		lib/afera/tap/csb.tap \
		lib/afera/tap/csb-256.tap \
		lib/afera/tap/s-plus.tap \
		dis.tap \
		> dis_compiling.tap

################################################################
# Clean

.PHONY : clean
clean:
	rm -f fig-forth.tap

################################################################
# Change history

# 2015-05-13: Start.
# 2015-05-23: "dis" moved from the Afera library.
