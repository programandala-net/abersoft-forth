#! /usr/bin/env gforth

\ abersoftforth2z80dasm.fs
\
\ AbersoftForth2z80dasm Version A-00-2015052021
\
\ This file is part of the "Abersoft Forth disassembled" project
\
\ This program reads the ZX Spectrum Abersoft Forth code and creates
\ two files needed by z80dasm in order to disassemble it: the data
\ blocks file and the symbols file.

\ Copyright (C) 2015 Marcos Cruz (programandala.net)

\ This program is free software; you can redistribute
\ it and/or modify it under the terms of the GNU General
\ Public License as published by the Free Software
\ Foundation; either version 2 of the License, or (at your
\ option) any later version.

\ This program is distributed in the hope that it will be useful, but
\ WITHOUT ANY WARRANTY; without even the implied warranty of
\ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
\ General Public License for more details.

\ You should have received a copy of the GNU General Public License
\ along with this program; if not, see <http://gnu.org/licenses>.

\ This program is written in Forth
\ with Gforth (<http://gnu.org/software/gforth/>).

\ }}} **********************************************************
\ Development history {{{

\ See at the end of this file.

\ }}} **********************************************************
\ Todo {{{

\ -origin argument
\ -v verbose argument
\
\ mark more known routines

\ }}} **********************************************************
\ Stack notation {{{

\ In this program the following stack notation is used:

0 [if]

+n      = 32-bit positive number
-n      = 32-bit negative number
a       = 32-bit memory address
ca      = 32-bit character aligned memory address
ca len  = character aligned memory zone (e.g. a string)
b       = 8-bit byte
c       = 8-bit character
f       = flag (true if not 0; false if 0)
false   = 0
ff      = 32-bit well formed flag (true if -1; false if 0)
i*x     = undefined group of elements (maybe empty)
j*x     = undefined group of elements (maybe empty)
n       = 32-bit signed number
nt      = name token
true    = 32-bit -1
u       = 32-bit unsigned number
x       = undefined element
xc      = x-character (UTF-8)
xca     = 32-bit x-character aligned memory address (for UTF-8)
xca u   = x-character aligned memory zone (a UTF-8 string)
xt      = execution token

[then]

\ }}} **********************************************************
\ Requirements {{{

\ From Forth Foundation Library
\ (<http://code.google.com/p/ffl/>)
require ffl/str.fs  \ dynamic strings

\ The Forth Foundation Library's config.fs file nullifies the
\ words 'argc' and 'arg', and defines its own versions '#args'
\ and 'arg@'.

[defined] ffl.version [if]

  \ Re-create the original Gforth words 'argc' and 'arg', based
  \ on the words defined by the Forth Foundation Library's
  \ config.fs. 

  warnings @ warnings off

  variable argc  #args 1+ argc !
  : arg  ( n -- ca len )
    1- arg@
    ;

  warnings !

[then]

\ }}} **********************************************************
\ Dynamic strings {{{

str-create abersoftforth_word_label$  \ base for the Z80 labels
str-create tmp$

\ }}} **********************************************************
\ Files {{{

variable 'abersoftforth  \ address of the Abersoft Forth code
variable /abersoftforth  \ length of the Abersoft Forth code  / xxx not used
: get_the_binary  ( ca len -- )
  \ Read the Abersoft Forth's binary.
  \ ca len = filename
  slurp-file /abersoftforth ! 'abersoftforth !
  ;
variable blocks_fid  \ file identifier
: create_blocks_file  ( ca len -- )
  \ Create the z80dasm's blocks file.
  \ ca len = filename
  w/o create-file abort" Error creating the blocks file"
  blocks_fid !
  ;
variable symbols_fid  \ file identifier
: create_symbols_file  ( ca len -- )
  \ Create the z80dasm's symbols file.
  \ ca len = filename
  w/o create-file abort" Error creating the symbols file"
  symbols_fid !
  ;
: close_files  ( -- )
  \ Close the new files.
  symbols_fid @ close-file abort" Error closing the symbols file"
  blocks_fid @ close-file abort" Error closing the blocks file"
  ;
: open_files  ( ca len -- )
  \ Open or create all needed files using the binary's filename.
  \ ca len = filename of the binary
  2dup get_the_binary
  2dup s" _blocks.txt" s+ create_blocks_file
  s" _symbols.z80s" s+ create_symbols_file
  ;

\ }}} **********************************************************
\ abersoftforth memory {{{

false value abersoftforth-b?  \ variant: abersoftforth-B instead of abersoftforth-A?

: abersoftforth-a?  ( a -- ff )
  \ abersoftforth-A instead of abersoftforth-B?
  abersoftforth-b? 0=
  ;
: z80@  ( a1 -- a2 )
  \ Fetch a 16-bit number from a Z80 address.
  dup c@ swap 1+ c@ 256 * +
  ;
: sam>heap  ( a1 -- a2 )
  \ Convert an Abersoft Forth address to a real heap address.
  abersoftforth-b? abs 16384 * -
  'abersoftforth @ +
  ;
: abersoftforth@  ( a1 -- u )
  \ Fetch a 16-bit number from an Abersoft Forth address.
  sam>heap z80@
  ;
: abersoftforthc@  ( a1 -- b )
  \ Fetch an 8-bit number from an Abersoft Forth address.
  sam>heap c@
  ;
: choose  ( a1 a2 -- a1 | a2 )
  \ Choose one of two addresses, depending on the current
  \ version of abersoftforth.
  abersoftforth-b? if  nip  else  drop  then
  ;
: var  ( a -- a | a' )
  \ Convert a variable address from abersoftforth to abersoftforth-B, if
  \ needed.
  16292 abersoftforth-b? abs * +
  ;
: abersoftforth_var_RSTACK  ( -- a )
  \ Return the content of the Abersoft Forth's variable "RSTACK":
  \ the start address of the return stack:
  \ the stack bottom, higher in memory.
  414 var abersoftforth@
  ;
: abersoftforth_var_STACK  ( -- a )
  \ Return the content of the Abersoft Forth's variable "STACK":
  \ the start address of the data stack:
  \ the stack bottom, higher in memory.
  414 var abersoftforth@
  ;
: abersoftforth_var_STKEND  ( -- a )
  \ Return the content of the Abersoft Forth's variable "STKEND":
  \ the end address of the data stack:
  \ the stack max top, lower in memory.
  416 var abersoftforth@
  ;
: abersoftforth_var_CLATE  ( -- a )
  \ Return the content of the Abersoft Forth's variable "CLATE":
  \ the address of the last abersoftforth word in the dictionary.
  421 var abersoftforth@
  ;
: abersoftforth_var_TIB  ( -- a )
  \ Return the content of the Abersoft Forth's variable "TIB":
  \ the start address of the Terminal Input Buffer.
  433 var abersoftforth@
  ;
: abersoftforth_var_PAD  ( -- a )
  \ Return the content of the Abersoft Forth's variable "PAD":
  \ the start address of the temporary data holding area.
  435 var abersoftforth@
  ;
: abersoftforth_var_ETIB  ( -- a )
  \ Return the content of the Abersoft Forth's variable "ETIB":
  \ the end address of the Terminal Input Buffer.
  472 var abersoftforth@
  ;

\ }}} **********************************************************
\ abersoftforth words structure {{{

variable 'word_name  \ address of the current word name in the Abersoft Forth code

: 'name>'link_field  ( a1 -- a2 )
  \ Convert the address of an Abersoft Forth word name
  \ to the address of its link field address.
  3 -
  ;
: 'name>'name_field  ( a1 -- a2 )
  \ Convert the address of an Abersoft Forth word name
  \ to the address of its name field address.
  1-
  ;
: 'name>'length  ( a1 -- a2 )
  \ Convert the address of an Abersoft Forth word name
  \ to the address of its length.
  1-
  ;
: -flags  ( u1 -- u2 )
  \ u1 = content of the name length byte of a word
  \ u2 = actual length of the word
  %00111111 and
  ;
: 'name>length  ( a1 -- u )
  \ Convert the address of an Abersoft Forth word name
  \ to its length.
  'name>'length abersoftforthc@ -flags
  ;
: word_name_length  ( -- u )
  \ Return the length of the current abersoftforth word.
  'word_name @ 'name>length
  ;
: counted  ( a -- ca len )
  \ Convert the address of an Abersoft Forth word name to a counted
  \ string.
  dup sam>heap swap 'name>length
  ;
: 'link_field  ( -- a )
  \ Return the link field address of the current abersoftforth word. 
  'word_name @ 'name>'link_field
  ;
: 'name_field  ( -- a )
  \ Return the name field address of the current abersoftforth word. 
  'word_name @ 'name>'name_field
  ;
: 'code_field  ( -- a )
  \ Return the code field address of the current abersoftforth word. 
  'word_name @ word_name_length +
  ;
: header_start  ( -- a )
  \ Return the start address of the current abersoftforth word's header.
  'link_field
  ;
: header_end  ( -- a )
  \ Return the end address of the current abersoftforth word's header.
  'code_field 
  ;

\ }}} **********************************************************
\ Strings manipulation {{{

: c>s  ( c u -- ca len )
  \ Make a temporary string from a character and a length.
  pad swap 2dup 2>r  rot fill  2r>
  ;
: /spaces  ( n1 n2 -- ca len )
  \ Return a string of n2 spaces minus n1; 
  \ used to tabulate the data on the files.
  swap - dup 0<= if
    drop 1
  then  bl swap c>s
  ;
: indentation+  ( ca len -- ca' len' )
  \ Add indentation spaces to a data field.
  dup 32 /spaces s+ 
  ;
: bl+  ( ca len -- ca' len' )
  \ Add a space to a string.
  s"  " s+
  ;
: n>hex  ( n -- ca len )
  \ Convert a number to a 4-digit hexadecimal string.
  base @ >r hex  s>d <# # # # # #>  r> base !
  ;
: n>0x  ( n -- ca len )
  \ Convert a number to a 4-digit hexadecimal string with the "0x" prefix.
  s" 0x" rot n>hex s+
  ;
: n>h  ( n -- ca len )
  \ Convert a number to a 4-digit hexadecimal string with the "h" sufix.
  n>hex s" h" s+
  ;

\ }}} **********************************************************
\ File data fields {{{

: blocks_file_abort  ( ff -- )
  \ Abort if an error ocurred while writing to the blocks file.
  abort" Error writing the blocks file"
  ;
: >blocks_file  ( ca len -- )
  \ Write a string into the blocks file.
  blocks_fid @ write-file blocks_file_abort
  ;
: >blocks_file_cr  ( ca len -- )
  \ Write a line into the blocks file.
  blocks_fid @ write-line blocks_file_abort
  ;
: .block_id  ( ca len -- )
  \ Print a block identifier field into the blocks file.
  \ ca len = id 
  s" :" s+ indentation+ >blocks_file
  ;
: .block_bound  ( a ca1 len1 -- )
  \ Print a block bound field into the blocks file.
  \ a = address of the bound
  \ ca1 len1 = name of the bound ("start" or "end")
  bl+ rot n>0x s+ bl+ >blocks_file
  ;
: .block_start  ( a -- )
  \ Print a block start field into the blocks file.
  \ a = block start address
  s" start" .block_bound
  ;
: .block_end  ( a -- )
  \ Print a block end field into the blocks file.
  \ a = block end address
  \ Note: for the z80dasm disassembler, the it's the block end
  \ address is the 16-bit address of the last byte in the block
  \ plus one.
  s" end" .block_bound
  ;
: .block_type  ( ca len -- )
  \ Print a block type field into the blocks file.
  \ ca len = type
  s" type " 2swap s+  >blocks_file_cr
  ;
: word_header_block  ( -- )
  \ Create a new block definition in the blocks file.
  \ xxx todo -- create own block for the name
  abersoftforth_word_label$ str-get s" _header" s+ 
  \ 2dup type  \ xxx debug check
  .block_id
  header_start .block_start
  header_end .block_end
  s" bytedata" .block_type
  \ ." [end of word_header_block]"  \ xxx todo
  ;

: symbols_file_abort  ( ff -- )
  \ Abort if an error ocurred while writing to the symbols file.
  abort" Error writing the symbols file"
  ;
: >symbols_file  ( ca len -- )
  \ Write a string into the symbols file.
  symbols_fid @ write-file symbols_file_abort
  ;
: >symbols_file_cr  ( ca len -- )
  \ Write a line into the symbols file.
  symbols_fid @ write-line symbols_file_abort
  ;
: .symbol_id  ( ca len -- )
  \ Print a symbol identifier field into the symbols file.
  \ ca len = id
  s" :" s+ indentation+ >symbols_file
  ;
: .symbol_value  ( x -- )
  \ Print a symbol value field into the symbols file.
  \ x = value
  s" equ " rot n>0x s+ >symbols_file_cr
  ;
: .symbol  ( x ca len -- )
  \ Print a symbol into the symbols file.
  \ x = value
  \ ca len = id
  .symbol_id .symbol_value
  ;
: code_field  ( -- )
  \ Create a symbol for the code field of the current abersoftforth
  \ word.
  'code_field
  abersoftforth_word_label$ str-get s" _code_field" s+ .symbol
  ;
: link_field  ( -- )
  \ Create a block for the link field of the current abersoftforth word.
  abersoftforth_word_label$ str-get s" _link_field" s+ .block_id
  'link_field dup .block_start
  2 + .block_end
  s" worddata" .block_type
  ;
: name_field  ( -- )
  \ Create the symbols and blocks for the name field
  \ of the current abersoftforth word.
  abersoftforth_word_label$ str-get s" _name_field" s+ .block_id
  'name_field dup .block_start
  word_name_length + 1+ .block_end
  s" bytedata" .block_type
  'word_name @ 
  abersoftforth_word_label$ str-get s" _name" s+ .symbol
  ;

\ }}} **********************************************************
\ Usage {{{

: usage  ( -- )
  \ Show the usage instructions.
  cr
  ." abersoftforth2z80dasm" cr
  ." Copyright (C) 2012 Marcos Cruz (programandala.net)" cr cr
  ." Usage:" cr
  ."   One or two filenames are accepted as parameters." cr
  ."   The first one must be the binary of abersoftforth;" cr
  ."   the second one must be the binary of abersoftforth-B." cr cr
  ." Examples:" cr
  ."    abersoftforth2z80dasm.fs abersoftforth.bin" cr
  ."    abersoftforth2z80dasm.fs abersoftforth.bin abersoftforth-b.bin" cr cr
  ." More information:" cr
  ."   <http://programandala.net/en.program.abersoftforth2z80dasm>" cr
  ;

\ }}} **********************************************************
\ abersoftforth words {{{

\ The following words return the base label name of every
\ abersoftforth word.
\ They will be executed with 'evaluate', as a way
\ to map the original Forth word names to their Z80 labels.
\ A string table approach would be more elegant, though.
: abersoftforth_word_LIT  ( -- ca len )  s" lit" ;
: abersoftforth_word_EXECUTE  ( -- ca len )  s" execute" ;
: abersoftforth_word_BRANCH  ( -- ca len )  s" branch" ;
: abersoftforth_word_0BRANCH  ( -- ca len )  s" zero_branch" ;
: abersoftforth_word_SWAP  ( -- ca len )  s" swap" ;
: abersoftforth_word_DUP  ( -- ca len )  s" dup" ;
: abersoftforth_word_DROP  ( -- ca len )  s" drop" ;
: abersoftforth_word_INTERPRET  ( -- ca len )  s" interpret" ;
: abersoftforth_word_(FIND)  ( -- ca len )  s" paren_find" ;
: abersoftforth_word_U*  ( -- ca len )  s" u_mult" ;
: abersoftforth_word_+  ( -- ca len )  s" plus" ;
: abersoftforth_word_D+  ( -- ca len )  s" d_plus" ;
: abersoftforth_word_-  ( -- ca len )  s" minus" ;
: abersoftforth_word_MINUS  ( -- ca len )  s" do_minus" ;
: abersoftforth_word_DMINUS  ( -- ca len )  s" d_do_minus" ;
: abersoftforth_word_NUMBER  ( -- ca len )  s" number" ;
: abersoftforth_word_EMIT  ( -- ca len )  s" emit" ;
: abersoftforth_word_U.  ( -- ca len )  s" u_dot" ;
: abersoftforth_word_/MOD  ( -- ca len )  s" slash_mod" ;
: abersoftforth_word_CLS  ( -- ca len )  s" cls" ;
: abersoftforth_word_CREATE  ( -- ca len )  s" create" ;
: abersoftforth_word_:  ( -- ca len )  s" colon" ;
: abersoftforth_word_;  ( -- ca len )  s" semicolon" ;
: abersoftforth_word_CR  ( -- ca len )  s" cr" ;
: abersoftforth_word_MODE  ( -- ca len )  s" mode" ;
: abersoftforth_word_VLIST  ( -- ca len )  s" vlist" ;
: abersoftforth_word_BASE  ( -- ca len )  s" base" ;
: abersoftforth_word_DECIMAL  ( -- ca len )  s" decimal" ;
: abersoftforth_word_HEX  ( -- ca len )  s" hex" ;
: abersoftforth_word_C,  ( -- ca len )  s" c_comma" ;
: abersoftforth_word_,  ( -- ca len )  s" comma" ;
: abersoftforth_word_ALLOT  ( -- ca len )  s" allot" ;
: abersoftforth_word_!  ( -- ca len )  s" store" ;
: abersoftforth_word_C!  ( -- ca len )  s" c_store" ;
: abersoftforth_word_@  ( -- ca len )  s" fetch" ;
: abersoftforth_word_C@  ( -- ca len )  s" c_fetch" ;
: abersoftforth_word_HERE  ( -- ca len )  s" here" ;
: abersoftforth_word_LATEST  ( -- ca len )  s" latest" ;
: abersoftforth_word_;CODE  ( -- ca len )  s" semicolon_code" ;
: abersoftforth_word_CODE:  ( -- ca len )  s" code_colon" ;
: abersoftforth_word_IN  ( -- ca len )  s" in" ;
: abersoftforth_word_OUT  ( -- ca len )  s" out" ;
: abersoftforth_word_PAGE  ( -- ca len )  s" page" ;
: abersoftforth_word_DO  ( -- ca len )  s" do" ;
: abersoftforth_word_+LOOP  ( -- ca len )  s" plus_loop" ;
: abersoftforth_word_LOOP  ( -- ca len )  s" loop" ;
: abersoftforth_word_I  ( -- ca len )  s" i" ;
: abersoftforth_word_LINK  ( -- ca len )  s" link" ;
: abersoftforth_word_AT  ( -- ca len )  s" at" ;
: abersoftforth_word_BORDER  ( -- ca len )  s" border" ;
: abersoftforth_word_BEEP  ( -- ca len )  s" beep" ;
: abersoftforth_word_."  ( -- ca len )  s" dot_quote" ;
: abersoftforth_word_SC!  ( -- ca len )  s" sc_store" ;
: abersoftforth_word_SC@  ( -- ca len )  s" sc_fetch" ;
: abersoftforth_word_P  ( -- ca len )  s" p" ;
: abersoftforth_word_CLEAR  ( -- ca len )  s" clear" ;
: abersoftforth_word_L  ( -- ca len )  s" l" ;
: abersoftforth_word_B  ( -- ca len )  s" b" ;
: abersoftforth_word_R  ( -- ca len )  s" r" ;
: abersoftforth_word_C  ( -- ca len )  s" c" ;
: abersoftforth_word_E  ( -- ca len )  s" e" ;
: abersoftforth_word_UP  ( -- ca len )  s" up" ;
: abersoftforth_word_DN  ( -- ca len )  s" dn" ;
: abersoftforth_word_NEWL  ( -- ca len )  s" newl" ;
: abersoftforth_word_LIST  ( -- ca len )  s" list" ;
: abersoftforth_word_T  ( -- ca len )  s" t" ;
: abersoftforth_word_ES  ( -- ca len )  s" es" ;
: abersoftforth_word_FROM  ( -- ca len )  s" from" ;
: abersoftforth_word_F  ( -- ca len )  s" f" ;
: abersoftforth_word_TO  ( -- ca len )  s" to" ;
: abersoftforth_word_EDIT  ( -- ca len )  s" edit" ;
: abersoftforth_word_N  ( -- ca len )  s" n" ;
: abersoftforth_word_DEL  ( -- ca len )  s" del" ;
: abersoftforth_word_D  ( -- ca len )  s" d" ;
: abersoftforth_word_INS  ( -- ca len )  s" ins" ;
: abersoftforth_word_S  ( -- ca len )  s" s" ;
: abersoftforth_word_H  ( -- ca len )  s" h" ;
: abersoftforth_word_LOAD  ( -- ca len )  s" load" ;
: abersoftforth_word_WHERE  ( -- ca len )  s" where" ;
: abersoftforth_word_*  ( -- ca len )  s" star" ;
: abersoftforth_word_TYPE  ( -- ca len )  s" type" ;
: abersoftforth_word_SAM  ( -- ca len )  s" sam" ;
: abersoftforth_word_SAVE  ( -- ca len )  s" save" ;
: abersoftforth_word_DIR  ( -- ca len )  s" dir" ;
: abersoftforth_word_=  ( -- ca len )  s" equals" ;
: abersoftforth_word_/  ( -- ca len )  s" slash" ;
: abersoftforth_word_MOD  ( -- ca len )  s" mod" ;
: abersoftforth_word_BEGIN  ( -- ca len )  s" begin" ;
: abersoftforth_word_UNTIL  ( -- ca len )  s" until" ;
: abersoftforth_word_<  ( -- ca len )  s" less_than" ;
: abersoftforth_word_>  ( -- ca len )  s" greater_than" ;
: abersoftforth_word_R>  ( -- ca len )  s" to_r" ;
: abersoftforth_word_>R  ( -- ca len )  s" r_from" ;
: abersoftforth_word_KEY  ( -- ca len )  s" key" ;
: abersoftforth_word_OVER  ( -- ca len )  s" over" ;
: abersoftforth_word_ROT  ( -- ca len )  s" rot" ;
: abersoftforth_word_2DUP  ( -- ca len )  s" two_dup" ;
: abersoftforth_word_PAD  ( -- ca len )  s" pad" ;
: abersoftforth_word_QUERY  ( -- ca len )  s" query" ;
: abersoftforth_word_RETYPE  ( -- ca len )  s" retype" ;
: abersoftforth_word_WORD  ( -- ca len )  s" word" ;
: abersoftforth_word_IF  ( -- ca len )  s" if" ;
: abersoftforth_word_ELSE  ( -- ca len )  s" else" ;
: abersoftforth_word_ENDIF  ( -- ca len )  s" endif" ;
: abersoftforth_word_THEN  ( -- ca len )  s" then" ;
: abersoftforth_word_<BUILDS  ( -- ca len )  s" builds" ;
: abersoftforth_word_DOES>  ( -- ca len )  s" does" ;
: abersoftforth_word_WHILE  ( -- ca len )  s" while" ;
: abersoftforth_word_REPEAT  ( -- ca len )  s" repeat" ;
: abersoftforth_word_VARIABLE  ( -- ca len )  s" variable" ;
: abersoftforth_word_CONSTANT  ( -- ca len )  s" constant" ;
: abersoftforth_word_.  ( -- ca len )  s" dot" ;
: abersoftforth_word_CMOVE  ( -- ca len )  s" cmove" ;
: abersoftforth_word_AND  ( -- ca len )  s" and" ;
: abersoftforth_word_OR  ( -- ca len )  s" or" ;
: abersoftforth_word_XOR  ( -- ca len )  s" xor" ;
: abersoftforth_word_NOT  ( -- ca len )  s" not" ;
: abersoftforth_word_FIND  ( -- ca len )  s" find" ;
: abersoftforth_word_COLD  ( -- ca len )  s" cold" ;
: abersoftforth_word_FENCE  ( -- ca len )  s" fence" ;
: abersoftforth_word_U/MOD  ( -- ca len )  s" u_slash_mod" ;
: abersoftforth_word_<#  ( -- ca len )  s" less_number_sign" ;
: abersoftforth_word_#>  ( -- ca len )  s" number_sign_greater" ;
: abersoftforth_word_#  ( -- ca len )  s" number_sign" ;
: abersoftforth_word_#S  ( -- ca len )  s" number_sign_s" ;
: abersoftforth_word_D.  ( -- ca len )  s" d_dot" ;
: abersoftforth_word_HOLD  ( -- ca len )  s" hold" ;
: abersoftforth_word_SIGN  ( -- ca len )  s" sign" ;
: abersoftforth_word_0=  ( -- ca len )  s" zero_equals" ;
: abersoftforth_word_0<  ( -- ca len )  s" zero_less" ;
: abersoftforth_word_INKEY  ( -- ca len )  s" inkey" ;
: abersoftforth_word_FORGET  ( -- ca len )  s" forget" ;
: abersoftforth_word_ERROR  ( -- ca len )  s" error" ;
: abersoftforth_word_(  ( -- ca len )  s" paren" ;
: abersoftforth_word_PICK  ( -- ca len )  s" pick" ;
: abersoftforth_word_ROLL  ( -- ca len )  s" roll" ;
: abersoftforth_word_ASCII  ( -- ca len )  s" ascii" ;
: abersoftforth_word_PAPER  ( -- ca len )  s" paper" ;
: abersoftforth_word_PEN  ( -- ca len )  s" pen" ;
: abersoftforth_word_BRIGHT  ( -- ca len )  s" bright" ;
: abersoftforth_word_FLASH  ( -- ca len )  s" flash" ;
: abersoftforth_word_COLOUR  ( -- ca len )  s" colour" ;
: abersoftforth_word_PLOT  ( -- ca len )  s" plot" ;
: abersoftforth_word_DRAW  ( -- ca len )  s" draw" ;
: abersoftforth_word_DRAWBY  ( -- ca len )  s" drawby" ;
: abersoftforth_word_?SCROLL  ( -- ca len )  s" question_scroll" ;
: abersoftforth_word_PALETTE  ( -- ca len )  s" palette" ;
: abersoftforth_word_DRIVE  ( -- ca len )  s" drive" ;
: abersoftforth_word_SV@  ( -- ca len )  s" sv_fetch" ;
: abersoftforth_word_SV!  ( -- ca len )  s" sv_store" ;
: abersoftforth_word_SVC@  ( -- ca len )  s" sv_c_fetch" ;
: abersoftforth_word_SVC!  ( -- ca len )  s" sv_c_store" ;
: abersoftforth_word_SOUND  ( -- ca len )  s" sound" ;
: abersoftforth_word_SOFF  ( -- ca len )  s" soff" ;
: abersoftforth_word_ROLS  ( -- ca len )  s" rols" ;
: abersoftforth_word_CSIZE  ( -- ca len )  s" csize" ;
: abersoftforth_word_UDGDEF  ( -- ca len )  s" udgdef" ;
: abersoftforth_word_SCREEN  ( -- ca len )  s" screen" ;
: abersoftforth_word_BLITZ  ( -- ca len )  s" blitz" ;
: abersoftforth_word_BLITZ$  ( -- ca len )  s" blitz_dollar" ;
: abersoftforth_word_PUT  ( -- ca len )  s" put" ;
: abersoftforth_word_PUT$  ( -- ca len )  s" put_dollar" ;
: abersoftforth_word_FILL  ( -- ca len )  s" fill" ;
: abersoftforth_word_GRAB  ( -- ca len )  s" grab" ;
: abersoftforth_word_GRAB$  ( -- ca len )  s" grab_dollar" ;
: abersoftforth_word_TAB  ( -- ca len )  s" tab" ;
: abersoftforth_word_OVERP  ( -- ca len )  s" overp" ;
: abersoftforth_word_INVERSE  ( -- ca len )  s" inverse" ;
: abersoftforth_word_BLOAD  ( -- ca len )  s" bload" ;
: abersoftforth_word_BSAVE  ( -- ca len )  s" bsave" ;
: abersoftforth_word_DLOAD  ( -- ca len )  s" dload" ;
: abersoftforth_word_DSAVE  ( -- ca len )  s" dsave" ;
: abersoftforth_word_EXPAND  ( -- ca len )  s" expand" ;

\ abersoftforth-B only:
: abersoftforth_word_POP-DE  ( -- ca len )  s" pop_de" ;
: abersoftforth_word_POP-HL  ( -- ca len )  s" pop_hl" ;
: abersoftforth_word_PUSH-DE  ( -- ca len )  s" push_de" ;
: abersoftforth_word_PUSH-HL  ( -- ca len )  s" push_hl" ;

: abersoftforth_word>label  ( ca1 len1 -- ca2 len2 )
  \ Convert the real name of an Abersoft Forth word
  \ to its base label name for z80dasm.
  s" abersoftforth_word_" 2swap s+ 
  \ 2dup space ." [EVALUATE: " type ." ]"  \ xxx debug check
  evaluate
  \ 2dup space ." [LABEL: " type ." ]" cr .s  \ xxx debug check
  ;

: abersoftforth_word  ( a -- )
  \ Extract the information from an Abersoft Forth word.
  \ a = address of the word name in the SAM memory. 
  \ ca1 len1 = word name
  dup 'word_name !  counted  ( ca1 len1 )
  \ 2dup cr type \ key drop  \ xxx debug check
  abersoftforth_word>label abersoftforth_word_label$ str-set
  \ word_header_block
  link_field
  name_field
  code_field
  ;
: last_word?  ( a -- ff )
  \ a = abersoftforth address of the previous Forth word name in the
  \ dictionary
  $ffff =
  ;
: abersoftforth_words  ( -- )
  \ Extract the information from all abersoftforth words.
  abersoftforth_var_CLATE 
  begin
    ( a )
    \ a = abersoftforth address of a Forth word name
    dup abersoftforth_word
    'name>'link_field abersoftforth@ dup last_word?
  until  drop
  ;

\ }}} **********************************************************
\ abersoftforth variables {{{

: (abersoftforth_var)  ( ca1 len1 a2 -- a2 )
  \ Create a symbol, the block identifier and block start of an Abersoft Forth variable.
  \ ca1 len1 = name of the variable
  \ a2 = address of the variable
  >r 2dup .block_id .symbol_id
  r> dup .block_start dup .symbol_value
  ;
: abersoftforth_short_var  ( ca1 len1 a2 -- )
  \ Create the symbol and the block of an Abersoft Forth 1-byte variable.
  \ ca1 len1 = name of the variable
  \ a2 = address of the variable
  >r .symbol_id
  r> .symbol_value
  ;
: abersoftforth_long_var  ( ca1 len1 a2 -- )
  \ Create the symbol and the block of an Abersoft Forth 2-byte variable.
  \ ca1 len1 = name of the variable
  \ a2 = address of the variable
  >r .symbol_id
  r> .symbol_value
  \ >r 2dup .block_id .symbol_id
  \ r> dup .block_start dup .symbol_value
  \ 1+ .block_end
  \ s" worddata" .block_type
  ;
variable vars_start  \ start address of the Abersoft Forth variables
variable vars_end  \ end address of the Abersoft Forth variables
: update_var_bounds  ( a u -- )
  \ Update the start and end of the Abersoft Forth variables region
  \ with the address of the current abersoftforth variable.
  \ a = address of the variable
  \ u = length of the variable (1 or 2 bytes)
  1- + dup
  vars_start @ min vars_start !
  vars_end @ max vars_end !
  ;
: abersoftforth_var  ( ca1 len1 a2 u2 -- )
  \ Create the symbol and the block of an Abersoft Forth variable.
  \ ca1 len1 = name of the variable
  \ a2 u2 = start and length of the variable
  2swap s" _fvar" s+ 2swap
  swap var swap
  2dup update_var_bounds
  case
    1 of  abersoftforth_short_var  endof
    2 of  abersoftforth_long_var  endof
  endcase
  ;

: (abersoftforth_vars)  ( -- )
  \ Create the symbols and the blocks of all abersoftforth variables.
  s" flags" 400 1 abersoftforth_var  \ various flags to control the system.
  s" lastk" 401 1 abersoftforth_var  \ ASCII code of last key pressed.
  s" bord" 402 1 abersoftforth_var  \ current border colour.
  s" frames1" 403 2 abersoftforth_var  \ counts television picture frames into a double number.
  s" frames2" 405 2 abersoftforth_var  \ counts television picture frames into a double number.
  s" ycord" 407 1 abersoftforth_var  \ last Y position plotted or drawn.
  s" xcord" 408 2 abersoftforth_var  \ last X position plotted or drawn.
  s" rstack" 410 2 abersoftforth_var  \ address of return stack (Z80 stack).
  s" stp" 412 2 abersoftforth_var  \ stack pointer to Forth stack.
  s" stack" 414 2 abersoftforth_var  \ start of Forth stack.
  s" stkend" 416 2 abersoftforth_var  \ end of Forth stack.
  s" samerr" 418 1 abersoftforth_var  \ holds SAM error number.
  s" nmi" 419 2 abersoftforth_var  \ address to jump to when NMI button pressed.
  s" clate" 421 2 abersoftforth_var  \ address of last Forth word in dictionary at cold start.
  s" chere" 423 2 abersoftforth_var  \ next vacant address in dictionary at cold start.
  s" latest" 425 2 abersoftforth_var  \ address of last Forth word in dictionary.
  s" here" 427 2 abersoftforth_var  \ next vacant address in dictionary.
  s" base" 429 2 abersoftforth_var  \ current number base.
  s" fence" 431 2 abersoftforth_var  \ address below which FORGET will not operate. It can be changed with the command FENCE.
  s" tib" 433 2 abersoftforth_var  \ start address of the Terminal Input Buffer.
  s" pad" 435 2 abersoftforth_var  \ start address of the temporary data holding area.
  s" st" 437 2 abersoftforth_var  \ star address of source, usually 32768. The page holding the source file is paged in at C & D.
  s" tempstk" 439 2 abersoftforth_var  \ used as temporary stack store.
  s" rampage" 441 1 abersoftforth_var  \ page number where source file will be held. Defaults to page 7.
  s" errsp" 442 2 abersoftforth_var  \ address at which return stack is set upon an error.
  s" corestore" 444 2 abersoftforth_var  \ next vacant address in dictionary at cold start.
  s" state" 446 1 abersoftforth_var  \ flag showing compile or imemediate mode.
  s" length" 447 1 abersoftforth_var  \ used to test for the length of a word being looked for in the dictionary.
  s" leng" 448 1 abersoftforth_var  \ used to test for the length of a word being looked for in the dictionary.
  s" ip" 449 2 abersoftforth_var  \ address of interpreter pointer within source being compiled.
  s" dubflag" 451 1 abersoftforth_var  \ flag indicating double number.
  s" bastack" 452 2 abersoftforth_var  \ holds stack pointer from SAM BASIC.
  s" edits" 454 2 abersoftforth_var  \ start address of source to be edited.
  s" numbit" 456 2 abersoftforth_var  \ temporary store used during number output.
  s" part1" 458 2 abersoftforth_var  \ temporary addresses used during number input.
  s" part2" 460 2 abersoftforth_var  \ temporary addresses used during number input.
  s" endf" 462 2 abersoftforth_var  \ temporary store used during number output.
  s" nega" 464 2 abersoftforth_var  \ flag for negative number during number output.
  s" temp1" 466 2 abersoftforth_var  \ temporary store for HERE during compiling.
  s" temp2" 468 2 abersoftforth_var  \ temporary store for LATEST during compiling.
  s" il1" 470 1 abersoftforth_var  \ length of input line before cursor.
  s" il2" 471 1 abersoftforth_var  \ length of input line after cursor.
  s" etib" 472 2 abersoftforth_var  \ end address of Terminal Input Buffer.
  s" iflag" 474 1 abersoftforth_var  \ flag indicating that characters may be inserted into the input line and existing input is not over written.
  s" ldflg" 475 1 abersoftforth_var  \ flag showing that source is being compiled.
  s" errhld" 476 2 abersoftforth_var  \ address of interpreter pointer position when an error occurred during source compilation.
  s" svblk" 478 2 abersoftforth_var  \ flag used during LOAD, SAVE, & DIR commands.
  s" slen" 480 2 abersoftforth_var  \ length of source to be saved.
  s" se" 482 2 abersoftforth_var  \ end address of source.
  s" sadd" 484 2 abersoftforth_var  \ address from where source will be LOADed or SAVEd.
  s" hlds" 486 2 abersoftforth_var  \ temporary store during number formatting.
  s" pairs" 488 2 abersoftforth_var  \ flags to indicate whether pairs such as DO..LOOP match up during compilation.
  s" pageno" 490 2 abersoftforth_var  \ holds number of page paged in at 32768 in sections C & D.
  s" cur" 492 2 abersoftforth_var  \ address of cursor in input buffer.
  s" smode" 494 2 abersoftforth_var  \ indicates SAM screen mode 1,2,3, or 4.
  s" notused0" 496 2 abersoftforth_var
  s" notused1" 498 2 abersoftforth_var
  s" notused2" 500 2 abersoftforth_var
  s" len2" 502 2 abersoftforth_var  \ used to increase or decrease length of source during editing.
  s" len1" 504 2 abersoftforth_var  \ used to increase or decrease length of source during editing.
  s" lists" 506 2 abersoftforth_var  \ start address of source list on screen, or of source to be SAVEd. Changed with T, N, FROM.
  s" elist" 508 2 abersoftforth_var  \ end address of source list on screen or source to be SAVed. Changed with N or ES.
  s" blong" 510 2 abersoftforth_var  \ used during source editing.
  s" endline" 512 2 abersoftforth_var  \ used during source editing.
  ;

: init_abersoftforth_vars_bounds  ( -- )
  \ Init the Abersoft Forth variables bounds.
  $ffff vars_start !  \ Z80 highest address
  0 vars_end !
  ;
: vars_block  ( -- )
  \ Create the Abersoft Forth variables block.
  s" variables" .block_id
  vars_start @ .block_start
  vars_end @ 1+ .block_end
  s" bytedata" .block_type
  ;
: abersoftforth_vars  ( -- )
  \ Create the symbols and the blocks of all abersoftforth variables.
  init_abersoftforth_vars_bounds
  (abersoftforth_vars)
  vars_block
  ;

\ }}} **********************************************************
\ abersoftforth call parameters {{{

: jsvin_parameter  ( a -- )
  \ Create a worddata block for the call parameter of the JSVIN
  \ ROM routine.
  dup s" JSVIN_parameter_" rot n>h s+ .block_id
  dup .block_start  2 + .block_end
  s" worddata" .block_type
  ;
: (abersoftforth-b_call_parameters)  ( -- )
  \ Create the blocks for the call parameters of ROM routines,
  \ in abersoftforth-B.
  $44b4 jsvin_parameter
  $44bb jsvin_parameter
  $44c1 jsvin_parameter
  $44d2 jsvin_parameter
  $44ea jsvin_parameter
  $460a jsvin_parameter
  $4613 jsvin_parameter
  $4644 jsvin_parameter
  $4652 jsvin_parameter
  $4740 jsvin_parameter
  $47de jsvin_parameter
  $47fe jsvin_parameter
  $4d19 jsvin_parameter
  $4d2a jsvin_parameter
  $4d3b jsvin_parameter
  $4d53 jsvin_parameter
  $4dd1 jsvin_parameter
  $5a83 jsvin_parameter
  $5a8c jsvin_parameter
  $5a9b jsvin_parameter
  $5eec jsvin_parameter
  ;
: abersoftforth_call_parameters  ( -- )
  \ Create the blocks for the call parameters of ROM routines.
  abersoftforth-b? if
    (abersoftforth-b_call_parameters)
  then
  ;

\ }}} **********************************************************
\ abersoftforth RST {{{

\ abersoftforth is paged at 0000h, so RST calls abersoftforth routines,
\ not ROM routines.

: abersoftforth_rst  ( n -- )
  \ Create a RST symbol in the symbols file. 
  base @ hex
  swap dup s>d <# # # #>
  s" rst" 2swap s+ .symbol_id
  .symbol_value
  base !
  ;
: abersoftforth_rsts  ( -- )
  \ Create symbols for the RST commands used by abersoftforth.
  abersoftforth-a? if
    $08 abersoftforth_rst
    $10 abersoftforth_rst
    $18 abersoftforth_rst
    $20 abersoftforth_rst
    $28 abersoftforth_rst
    $30 abersoftforth_rst
    $38 abersoftforth_rst
  then
  ;

\ }}} **********************************************************
\ abersoftforth routines {{{

: .rom_routine  ( a ca1 len1 -- )
  \ Create symbols for a ROM routine.
  s" _rom_routine" s+ .symbol
  ;
: (abersoftforth-b_routines)  ( -- )
  \ Create symbols for abersoftforth-B routines.
  $0103 s" jsvin" .rom_routine
  $014e s" jclsbl" .rom_routine
  $0112 s" jsetstrm" .rom_routine
  $4021 s" jp_push_hl" .symbol
  $4024 s" jp_pop_hl" .symbol
  $402a s" jp_pop_hl_de" .symbol
  $402d s" jp_error_a" .symbol
  $4d50 s" print_a" .symbol
  $4632 s" print_a_and_tos" .symbol
  $44be s" print_a_xxx_duplicated" .symbol
  $4060 s" jp_clear_lower_screen" .symbol
  $4641 s" clear_lower_screen" .symbol
  $4647 s" set_palette_l_to_e" .symbol
  \ The following symbols are not used because
  \ the jumps are direct to their routines:
  $4027 s" jp_push_hl_de" .symbol
  $4030 s" jp_print_a_xxx_duplicated" .symbol
  $6274 s" call_push_hl" .symbol
  $4fda s" return_from_basic" .symbol
  ;
: (abersoftforth-a_routines)  ( -- )
  \ Create symbols for abersoftforth-A routines.
  $0066 s" nmi_routine" .symbol
  $0030 s" jp_error_a" .symbol  \ Synonym for RST 30
  $00db s" jp_rom_rst10" .symbol  \ Called by RST 8
  $05e6 s" rom_rst10" .symbol  \ Jumped at jp_rom_rst10
  $195e s" get_keypress_with_what_xxx" .symbol
  $0743 s" print_a_and_tos" .symbol
  $0e36 s" error_0x08_break_xxx_not_called" .symbol
  $0cf9 s" jp_page_pageno_in_and_set_iy_to_flags_and_error_0x0a_not_found" .symbol
  $0d39 s" error_0x0b_editor_error" .symbol
  $06e4 s" error_0x0c_xxx_unknown" .symbol
  $010b s" jp_clear_lower_screen_and_set_palette_l_to_e" .symbol
  $074c s" clear_lower_screen_and_set_palette_l_to_e" .symbol
  ;
: (abersoftforth_routines)  ( -- )
  \ Create symbols for routines common to abersoftforth-A and
  \ abersoftforth-B (at different addresses).
	$00cc $4012 choose s" jp_page_pageno_in_and_set_iy_to_flags" .symbol
	$0811 $4718 choose s" jp_jp_page_pageno_in_and_set_iy_to_flags" .symbol
	$00d5 $401b choose s" jp_wait_for_keypress_and_return_it_in_a" .symbol
  $00c0 $4006 choose s" jp_main_loop" .symbol
  $00c6 $400c choose s" jp_u_dot_code_field" .symbol
  $00cf $4015 choose s" jp_interpret_code_field" .symbol
  $00d2 $4018 choose s" jp_keyboard_input" .symbol
  $00d8 $401e choose s" jp_de_hl_slash_mod" .symbol
  $0126 $407b choose s" jp_c_fetch_from_page_0" .symbol
  $0129 $407e choose s" jp_c_store_into_page_0" .symbol
  $00f0 $4045 choose s" jp_fetch_from_page_0" .symbol
  $0123 $4078 choose s" jp_store_into_page_0" .symbol
  $068a $4577 choose s" return_to_basic" .symbol
  $0799 $4698 choose s" c_fetch_from_page_0" .symbol
  $078c $4689 choose s" c_store_into_page_0" .symbol
  $077b $4674 choose s" fetch_from_page_0" .symbol
  $076c $4663 choose s" store_into_page_0" .symbol
  $0e05 $4d56 choose s" pop_hl" .symbol  \ Called by RST 18 
  $0e1f $4d70 choose s" push_hl" .symbol  \ Called by RST 10
  $0e3b $4d8c choose s" pop_hl_de" .symbol  \ Called by RST 28
  $0e60 $4db1 choose s" push_hl_de" .symbol  \ Called by RST 20
  $0e85 $4dce choose s" wait_for_keypress_and_return_it_in_a" .symbol
  $0e9d $4dd8 choose s" restore_the_input_pointer" .symbol
  $0eab $4de6 choose s" keyboard_input" .symbol
  $0f5a $4e9c choose s" print_cr" .symbol
  $1092 $501b choose s" main_loop" .symbol
  $10a0 $5029 choose s" error_a" .symbol  \ Called by RST 30
  $10a3 $502c choose s" error_message_not_found_yet" .symbol
  $10ab $5034 choose s" next_error_message_char" .symbol
  $10b4 $503f choose s" warm_restart" .symbol
  $117c $510a choose s" init" .symbol
  $11a9 $5136 choose s" save_dictionary_pointers" .symbol
  $11b6 $5143 choose s" restore_dictionary_pointers_and_set_interpretation_mode" .symbol
  $1234 $51d3 choose s" skip_space" .symbol
  $14ee $54f7 choose s" de_hl_slash_mod" .symbol
  $2135 $62c3 choose s" page_pageno_in_and_set_iy_to_flags" .symbol
  $066f $4558 choose s" sound_out_a_l" .symbol
  $00ea $403f choose s" jp_do_sound" .symbol
  $067a $4563 choose s" do_sound" .symbol
  $012c $4081 choose s" jp_sound_off" .symbol
  $0667 $4550 choose s" sound_off" .symbol
  $00de $4033 choose s" jp_change_drive_to_tos" .symbol
  $0760 $4655 choose s" change_drive_to_tos" .symbol
  $0117 $406c choose s" jp_call_jpalette" .symbol
  $0759 $464f choose s" call_jpalette" .symbol
  $00e4 $4039 choose s" jp_call_jdrawto" .symbol
  $071f $460d choose s" call_jdrawto" .symbol
  $0729 $4616 choose s" get_stack_coords_and_copy_to_bc" .symbol
  $00e1 $4036 choose s" jp_call_jplot" .symbol
  $0715 $4604 choose s" call_jplot" .symbol
  $1525 $5532 choose s" create_header_with_name_from_the_input_stream" .symbol
  $0111 $4066 choose s" jp_pen" .symbol
  $0739 $4628 choose s" pen" .symbol
  $010e $4063 choose s" jp_paper" .symbol
  $0735 $4624 choose s" paper" .symbol
  $0120 $4075 choose s" jp_bright" .symbol
  $0748 $463d choose s" bright" .symbol
  $011d $4072 choose s" jp_flash" .symbol
  $0741 $4630 choose s" flash" .symbol
  $0144 $4099 choose s" jp_inverse" .symbol
  $073d $462c choose s" inverse" .symbol
  $0141 $4096 choose s" jp_overp" .symbol
  $08e9 $4813 choose s" overp" .symbol
  $013e $4093 choose s" jp_tab" .symbol
  $08df $4801 choose s" tab" .symbol
  $00ff $4054 choose s" jp_at" .symbol
  $0614 $44ed choose s" at" .symbol
  $011a $406f choose s" jp_border" .symbol
  $061f $4500 choose s" border" .symbol
  $00e7 $403c choose s" jp_beep" .symbol
  $0627 $450a choose s" beep" .symbol
  $0153 $40a8 choose s" jp_editor_command_p" .symbol
  $094f $487d choose s" editor_command_p" .symbol
  $00c3 $4009 choose s" jp_page_rampage_in" .symbol
  $210f $6261 choose s" page_rampage_in" .symbol
  $0156 $40ab choose s" jp_clear" .symbol
  $0971 $489f choose s" clear" .symbol
  $0159 $40ae choose s" jp_editor_command_l" .symbol
  $097b $48a9 choose s" editor_command_l" .symbol
  $016b $40c0 choose s" jp_list" .symbol
  $0d54 $4c9a choose s" list" .symbol
  $0177 $40cc choose s" jp_editor_command_h" .symbol
  $0da4 $4cee choose s" editor_command_h" .symbol
  $00f9 $404e choose s" jp_load" .symbol
  $0a5f $4993 choose s" load" .symbol
  $0165 $40ba choose s" jp_where" .symbol
  $0aaf $49e3 choose s" where" .symbol
  $1085 $4fcb choose s" type_bc_chars_at_hl" .symbol
  $0147 $409c choose s" jp_bload" .symbol
  $08ee $4818 choose s" bload" .symbol
  $014a $409f choose s" jp_bsave" .symbol
  $08fd $4829 choose s" bsave" .symbol
  $014d $40a2 choose s" jp_dload" .symbol
  $0910 $483e choose s" dload" .symbol
  $0150 $40a5 choose s" jp_dsave" .symbol
  $0926 $4854 choose s" dsave" .symbol
  $1240 $51df choose s" first_char_to_interpret_found" .symbol
  $0f9e $4ee2 choose s" keyboard_input_cursor_left" .symbol
  $0fb8 $4efc choose s" keyboard_input_cursor_right" .symbol
  $0fda $4f1e choose s" keyboard_input_up" .symbol
  $0ff3 $4f37 choose s" keyboard_input_down" .symbol
  $0f38 $4e7e choose s" toggle_caps_lock" .symbol
  $1032 $4f76 choose s" toggle_insert_mode" .symbol
  $0f43 $4e85 choose s" keyboard_input_cr" .symbol
  $0f5e $4ea2 choose s" keyboard_input_backspace" .symbol
  $0f88 $4ecc choose s" keyboard_input_delete" .symbol
  $0f18 $4e53 choose s" keyboard_input_edit" .symbol
  $015f $40b4 choose s" jp_editor_command_to" .symbol
  $0a35 $4969 choose s" editor_command_to" .symbol
  $0180 $40d5 choose s" jp_editor_command_from" .symbol
  $09d9 $490d choose s" editor_command_from" .symbol
  $015c $40b1 choose s" jp_editor_command_f" .symbol
  $0a2b $495f choose s" editor_command_f" .symbol
  $013b $4090 choose s" jp_blitz" .symbol
  $08c6 $47e7 choose s" blitz" .symbol
  $0138 $408d choose s" jp_screen" .symbol
  $08b7 $47d6 choose s" screen" .symbol
  $0135 $408a choose s" jp_udgdef" .symbol
  $0861 $477c choose s" udgdef" .symbol
  $0132 $4087 choose s" jp_csize" .symbol
  $082f $4743 choose s" csize" .symbol
  $012f $4084 choose s" jp_rols" .symbol
  $0815 $471c choose s" rols" .symbol
  $00f6 $404b choose s" jp_colour" .symbol
  $07aa $46ad choose s" colour" .symbol
  $00f3 $4048 choose s" jp_mode" .symbol
  $05ed $44c4 choose s" mode" .symbol
  $00ed $4042 choose s" jp_cls" .symbol
  $05d6 $44a7 choose s" cls" .symbol
  $109a $5023 choose s" error_0x01_stack_empty" .symbol
  $109e $5027 choose s" error_0x02_stack_full" .symbol
  $12e0 $5295 choose s" error_0x04_colon_definitions_only_xxx_1" .symbol
  $1578 $5587 choose s" error_0x04_colon_definitions_only_xxx_2" .symbol
  $1495 $5486 choose s" error_0x03_undefined_word_xxx_1" .symbol
  $1e10 $5f20 choose s" error_0x03_undefined_word_xxx_2" .symbol
  $1503 $550e choose s" error_0x05_division_by_zero" .symbol
  $1e13 $5f25 choose s" error_0x08_break" .symbol
  $1701 $574a choose s" error_0x09_incomplete_form" .symbol
  $1597 $55aa choose s" error_0x0a_not_found" .symbol
  $15e4 $5601 choose s" base_a" .symbol
  $0162 $40b7 choose s" jp_editor_command_n" .symbol
  $0a4c $4980 choose s" editor_command_n" .symbol
  $0168 $40bd choose s" jp_edit" .symbol
  $0ac9 $49fd choose s" edit" .symbol
  $016e $40c3 choose s" jp_newl" .symbol
  $0d3c $4c82 choose s" newl" .symbol
  $0186 $40db choose s" jp_grab" .symbol
  $0dc1 $4d0b choose s" grab" .symbol
  $018c $40e1 choose s" jp_fill" .symbol
  $0ddd $4d2d choose s" fill" .symbol
  $0189 $40de choose s" jp_put" .symbol
  $0dcf $4d1c choose s" put" .symbol
  $0114 $4069 choose s" jp_dir" .symbol
  $0705 $45f4 choose s" dir" .symbol
  $0108 $405d choose s" jp_sam" .symbol
  $0682 $456f choose s" sam" .symbol
  $0102 $4057 choose s" jp_link" .symbol
  $05fd $44d5 choose s" link" .symbol
  $0105 $405a choose s" jp_link_l" .symbol
  $05fe $44d8 choose s" link_l" .symbol
  $0609 $44e7 choose s" link_a_not_to_channel_p" .symbol
  $060d $4478 choose s" link_a" .symbol
  $00fc $4051 choose s" jp_save" .symbol
  $06e7 $45d6 choose s" save" .symbol
  $070d $45fc choose s" call_rom_address_in_iy" .symbol
  $070d $45fc choose s" call_rom_address_in_iy" .symbol
  $12d0 $5283 choose s" compile_call_tos" .symbol
  $12d2 $5287 choose s" compile_call_de" .symbol
  $1985 $59ec choose s" push_true" .symbol
  $198a $59f3 choose s" push_false" .symbol
  ;
: abersoftforth_routines  ( -- )
  \ Create symbols for abersoftforth routines.
  (abersoftforth_routines)
  abersoftforth-b? if
    (abersoftforth-b_routines)
  else
    (abersoftforth-a_routines)
  then
  ;

\ }}} **********************************************************
\ SAM Coupé symbols {{{

: sam_coupé_symbols  ( -- )
  \ Create symbols related to SAM Coupé.
  \ xxx Not used.
  \ This is useless, because z80dasm only translates
  \ used addresses. This has to be done during
  \ the postprocessing of the assembly.
  250 s" LMPR" .symbol  \ Low Memory Page Register
  251 s" HMPR" .symbol  \ High Memory Page Register
  ;

\ }}} **********************************************************
\ abersoftforth data zones {{{

: abersoftforth_return_stack  ( -- )
  \ Create the block for the Abersoft Forth return stack.
  s" return_stack" .block_id
  abersoftforth_var_RSTACK dup .block_start
  256 + .block_end
  s" worddata" .block_type
  ;
: abersoftforth_data_stack  ( -- )
  \ Create the block for the Abersoft Forth data stack.
  s" data_stack" .block_id
  abersoftforth_var_STKEND .block_start
  abersoftforth_var_STACK .block_end
  s" worddata" .block_type
  ;
: abersoftforth_tib  ( -- )
  \ Create the block for the Abersoft Forth TIB.
  s" tib" .block_id
  abersoftforth_var_TIB .block_start
  abersoftforth_var_PAD .block_end
  s" bytedata" .block_type
  ;
: abersoftforth_pad  ( -- )
  \ Create the block for the Abersoft Forth PAD.
  s" pad" .block_id
  abersoftforth_var_PAD .block_start
  abersoftforth_var_STKEND .block_end
  s" bytedata" .block_type
  ;
: abersoftforth_error_messages  ( -- )
  \ Create the block for the Abersoft Forth error messages. 
  s" errors" .block_id
  $10e1 $506f choose .block_start
  $117c $510a choose .block_end
  s" bytedata" .block_type
  ;
: abersoftforth-b_special_zones  ( -- )
  \ Create some abersoftforth-B special block zones.
  abersoftforth-b? if
    s" xxx_unknown_zone_00b" .block_id
    $40e4 .block_start
    $4133 1+ .block_end
    s" bytedata" .block_type
    s" xxx_unknown_zone_01b" .block_id
    $4d3e .block_start
    $4d4f 1+ .block_end
    s" bytedata" .block_type
  endif
  ;
: a>hex  ( a -- ca len )
  \ Convert an address to a 4-digit lowarcase hex string. 
  base @ swap hex
  s>d <# # # # # #> tmp$ str-set
  tmp$ str-lower
  base !
  tmp$ str-get
  ;
: a>branch  ( a -- ca len )
  \ Convert an address to a label name.
  a>hex s" branch_" 2swap s+
  ;
: abersoftforth_0branch_datum  ( a1 a2 -- )
  \ Create block zone for one '0BRANCH'.
  \ a1 = start address in abersoftforth-A
  \ a2 = start address in abersoftforth-B
  2dup choose dup a>branch .block_id .block_start
  choose 2 + .block_end
  s" worddata" .block_type
  ;
: abersoftforth_0branch_jump  ( a1 a2 -- )
  \ Create a symbol for a '0BRANCH jump.
  \ a1 = address in abersoftforth-A
  \ a2 = address in abersoftforth-B
  choose dup a>branch .symbol
  ;
: abersoftforth_0branch_data  ( -- )
  \ Create block zones and jump symbols for all '0BRANCH'.
  $1d32 $5e2e abersoftforth_0branch_datum 
  $1d3b $5e39 abersoftforth_0branch_jump
  $1d5d $5e5d abersoftforth_0branch_datum
  $1d4b $5e4b abersoftforth_0branch_jump
  $1d9a $5e9e abersoftforth_0branch_datum
  $1da3 $5ea9 abersoftforth_0branch_jump
  $1dad $5eb3 abersoftforth_0branch_datum
  $1db2 $5eb8 abersoftforth_0branch_jump
  ;
: abersoftforth_special_zones  ( -- )
  \ Create some special block zones.
  s" xxx_unknown_zone_00" .block_id
  $0703 $45f2 choose .block_start
  $0704 $45f3 choose 1+ .block_end
  s" bytedata" .block_type
  $215b $62e9 choose s" cold_here" .symbol
  abersoftforth-b_special_zones
  abersoftforth_0branch_data
  ;
: abersoftforth_data_zones  ( -- )
  \ Create the blocks for the Abersoft Forth data zones.
  abersoftforth_return_stack
  abersoftforth_data_stack
  abersoftforth_tib
  abersoftforth_pad  
  abersoftforth_error_messages
  abersoftforth_special_zones
  ;

\ }}} **********************************************************
\ Argument checks {{{

: check_arguments#  ( -- )
  \ Make sure the number of parameters is one
  \ (the Gforth executable counts as one). 
  #args 1 3 within 0= if  \ 1 or 2 arguments?
    cr ." Error: Wrong number of arguments." cr
    usage bye
  then
  ;
: check_argument  ( n -- )
  \ Make sure the argument is right.
  arg 2dup  \ 2dup cr ." «" type ." »" \ xxx debug check
  file-status nip
  if
    cr ." Error: the '" type
    ." ' file can not be found." cr
    usage bye
  else
    2drop
  then  \ xxx todo check the status
  [ false ] [if]  \ xxx todo check the size
  32768 s>d d<>
  if
    cr ." Error: the'" type
    ." ' file length should be 32768." cr
    usage bye
  then
  [then]
  ;
: check_arguments  ( n -- )
  1 check_argument
  ;
: check
  \ Make sure the arguments are right.
  check_arguments# check_arguments
  ;
: .args  ( -- )
  \ Show all parameters. For debugging.
  argc @ 0 ?do
    i dup . ." arg = " arg type cr
    i dup . ." arg@ = " arg@ type cr
  loop  
  ;

\ }}} **********************************************************
\ Main {{{

: ((abersoftforth2z80dasm))  ( ca len -- )
  \ ca len = filename of the binary
  \ 'abersoftforth-b?' is set
  open_files
  abersoftforth_vars
  abersoftforth_words
  abersoftforth_routines
  abersoftforth_data_zones
  abersoftforth_rsts
  abersoftforth_call_parameters
  sam_coupé_symbols
  close_files
  ;
: (abersoftforth2z80dasm)  ( n -- )
  \ n = 0:abersoftforth, 1:abersoftforth-B
  dup 0<> to abersoftforth-b?
  arg@ ((abersoftforth2z80dasm))
  ;
: abersoftforth2z80dasm  ( -- )
  \ Main word
  #args 0 ?do
    i (abersoftforth2z80dasm)
  loop
  ;
: run ( -- )
  check abersoftforth2z80dasm
  ;

\ .args
run bye

\ }}} **********************************************************
\ Development history {{{

\ 2015-05-20: Start, based on the code of abersoftforth2z80dasm (version
\ A-00-201301241713), part of the "SamForth disassembled" project
\ (<http://programandala.net/en.program.samforth.html>).
