#!/bin/sh

# dsam_abersoft_forth.sh

# By Marcos Cruz (programandala.net)

# This file is a wrapper to disassemble
# Abersoft Forth.

# The change log is at the end of the file.

# ##############################################################
# Prepare the files needed for the disassembling
# with SamForth2z80dasm
# (<http://programandala.net/en.program.samforth2z80dasm>)

echo "Preparing the blocks and symbols files..."
./samforth2z80dasm.fs samforth-a.bin samforth-b.bin

# ##############################################################
# Disassemble

echo "Disassembling..."
#z80dasm --address --origin=24128 --labels --source --block-def=samforth-a.bin_blocks.txt --sym-input=samforth-a.bin_symbols.z80s --output=samforth-a.raw.z80s samforth-a.bin
z80dasm --address --origin=24128 --labels --source --output=abersoft_forth.raw.z80s abersoft_forth.bin

echo "Done!"

exit 0

# ##############################################################
# Change log

# 2014-09-01: Start.
