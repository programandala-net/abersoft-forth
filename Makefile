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
all: dis

.PHONY: z80
all: high low

.PHONY: high
high: abersoft_forth_high-level.z80s

.PHONY: low
low: abersoft_forth_low-level.z80s

################################################################
# Zones file

# Substitute the temporary labels with their definitive names in the
# raw printout produced by dis, and sort it.

# First try, bad sorting:
#dis_printout_tidied.txt: dis_printout.txt
#	sed --file word_labels.sed dis_printout.txt | \
#	sort > dis_printout_tidied.txt

# Second try, bad sorting:
#dis_printout_tidied.txt: dis_printout.txt
#	sed --file word_labels.sed dis_printout.txt > /tmp/dis.txt && \
#	sort /tmp/dis.txt > dis_printout_tidied.txt

# Third try, error 1, no clue:
#dis_printout_tidied.txt: dis_printout.txt
#	sed --file word_labels.sed dis_printout.txt | \
#	vim -e -c "sort|wq dis_printout_tidied.txt" - 

# 4th try, works:
dis_printout_tidied.txt: dis_printout.txt
	sed --file word_labels.sed dis_printout.txt > /tmp/dis.txt && \
	vim -e -c "sort|saveas! dis_printout_tidied.txt|q" /tmp/dis.txt 

# 5th try, error 1, no clue:
#dis_printout_tidied.txt: dis_printout.txt
#	sed --file word_labels.sed dis_printout.txt | \
#	vim -e -c "sort|saveas dis_printout_tidied.txt|q" - 

# Extract the z80dasm zones from the printout.

zones_dis.txt: dis_printout_tidied.txt
	grep "Z80DASM ZONE" dis_printout_tidied.txt | \
	sed --expression="s/^; \[Z80DASM ZONE] //" > \
		zones_dis.txt

# Combine both zones def files into one.

zones.txt: zones_dis.txt zones_manual.txt
	cat zones_dis.txt zones_manual.txt | \
	sort --field-separator=":" --key=2 > zones.txt

################################################################
# High level disassembly

abersoft_forth_high-level.z80s: dis_printout_tidied.txt
	grep --invert-match "Z80DASM ZONE" dis_printout_tidied.txt > \
		abersoft-forth_high-level.z80s

################################################################
# Low level disassembly

abersoft_forth_padded.bin: abersoft_forth.bin
	head --bytes=64 /dev/zero > abersoft_forth_padded.bin && \
	cat abersoft_forth.bin >> abersoft_forth_padded.bin && \
	head --bytes=1K /dev/zero >> abersoft_forth_padded.bin

# This does not work, produces an identical copy:
#	cat $$(head --bytes=6 /dev/zero) abersoft_forth.bin $$(head --bytes=1K /dev/zero) > \
#		abersoft_forth_padded.bin

abersoft_forth_low-level.z80s: \
	abersoft_forth_padded.bin \
	zones.txt \
	symbols_input.z80s
	z80dasm \
		--origin=24064 \
		--address \
		--source \
		--labels \
		--block-def=zones.txt \
		--sym-input=symbols_input.z80s \
		--output=abersoft_forth_low-level.z80s \
		abersoft_forth_padded.bin

################################################################
# dis

%.tap: %.fsb
	fsb2abersoft16k $<

.PHONY: dis
dis: dis_compiling.tap

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
