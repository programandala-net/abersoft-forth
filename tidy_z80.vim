" tidy_z80.vim

" This Vim program tidies the Z80 source created by z80dasm.

" This file is part of
"   Abersoft Forth disassembled
"   http://programandala.net/en.program.abersoft_forth.html
"

" --------------------------------------------------------------
" History

" 2015-05-26: Start.
" 2015-05: Improvements.

" --------------------------------------------------------------
" No default comments.

silent %s@^;.\+\n@@

" --------------------------------------------------------------
" Remove addresses and dump bytes at the end of the lines, except the address
" of the branch words, that are preserved in order to add labels to the
" branches.

silent %s@\(defw \(zero_branch\|branch\|paren_loop\|paren_plus_loop\)_cfa\)_first\s\+;\([0-9a-f]\{4}\) [0-9a-f]\{2}.\+$@\1 ; 0x\U\3@

silent %s@\s\+;[0-9a-f]\{4} [0-9a-f]\{2}.\+$@@

" --------------------------------------------------------------
" Change the format of hex numbers.

silent %s@\<0x\([0-9a-f]\+\)\>@0x\U\1@g
silent %s@\<0\([0-9a-f]\+\)h\>@0x\U\1@g

" --------------------------------------------------------------
" Rename labels that must be preserved.

%s@\<colon_pfa100_first\>@do_colon@
%s@\<constant_pfa100_first\>@do_constant@
%s@\<user_pfa100_first\>@do_user@
%s@\<two_variable_pfa100_first\>@do_two_variable@
%s@\<does_pfa100_first\>@do_does@
%s@\<variable_pfa100_first\>@do_variable@

" --------------------------------------------------------------
" Remove the end of zone labels.

silent %s@^\S\+_\(last\|end\):\n@@

" --------------------------------------------------------------
" Remove labels of literals and strings.

silent %s@^\(literal\|string\)_at_0x.\+:\n@@

" --------------------------------------------------------------
" Remove labels of secondary pfa zones.

silent %s@^[a-z0-9_]\+pfa\d\+_first:\n@@

" --------------------------------------------------------------
" Remove '_first' suffixes from labels.

silent %s@\<\([a-z0-9_]\+\)_first@\1@

" --------------------------------------------------------------
" Remove the tail after the last label.

silent /^l8159h:$/+1,$s@\_.\+@@

" --------------------------------------------------------------
" Rename some automatic labels.

silent %s@\<l8159h\>@dictionary_pointer_after_cold@g

" --------------------------------------------------------------
" Rename numbers that z80dasm could not convert
" to symbols because they appear in compiled literals,
" thus in worddata blocks.

silent %s@\<0x5C7B\>@sys_udg@g
call cursor(1,1)
call search('equ 0x5C7','wc')
call append(line('.'),'sys_udg: equ 0x5C7B')
,+2 sort

" --------------------------------------------------------------
" Remove empty lines.

silent %s@\n\n\+@\r@

" --------------------------------------------------------------
" Add comments, separation lines and rulers.

silent %s@defw 0xA081@& ; Dummy name field.@g

call search('^cpu_name:','wc')
call append(line('.'),'  ; CPU name stored as a 32-bit base 36 integer.')
call append(line('.')+1,'  ; XXX FIXME -- The number 0x0005B320 is "8080" in base 36,')
call append(line('.')+2,'  ; it should be 0x0000B250 ("Z80" in base 36).')

call search('^fig_user_version:','wc')
call append(line('.'),'  ; XXX FIXME -- It should be 0x41 ("A").')

%s@^  defw 0x2BFF$@& ; XXX FIXME -- It should be 0x2C00.@

%s@^exit_pfa:\n\s\+defw to_r_cfa$@& ; XXX FIXME -- Serious bug: It should be `R>` (r_from_cfa), not `>R` (to_r_cfa).@

%s@\(^\s\+defw semicolon_s_cfa\)\n\s\+ld c,b\n\s\+ld h,c@\1\r\1 ; XXX FIXME --  Unnecessary duplicated code.@

%s@^origin:$@\r  ; Parameter area\r\r&\r\r@

%s@^hld_value:\n\s\+defw \S\+$@&\r  ; Unused@

%s@^user_variables_origin:@\r  ; User variables\r\r&\r\r  ; Unused@

%s@^init_s0_value:@\r  ; User variables init values\r\r&\r@

%s@^user_pointer_value:$@\r&@

call search('^cold_entry:','wc')
call append(line('.')-1,'  ; Entry points'])

call search('^fig_release:','wc')
call append(line('.')-1,'')

call search('^cpu_name:','wc')
call append(line('.')-1,'')

call search('^pushde:','wc')
call append(line('.')-1,['','  ; Interpreter',''])

call search('^lit_nfa:','wc')
call append(line('.')-1,['','  ; Dictionary',''])

call search('^fig_implementation_attributes:$','wc')
call append(line('.')-01,'')
call append(line('.')+01,'')
call append(line('.')+00,'  ; Location: 0x0B +ORIGIN')
call append(line('.')+02,'  ; Bits:      76543210')
call append(line('.')+03,'  ; Bit names: ...WIEBA')
call append(line('.')+04,'  ; 0x0E =     00001110')
call append(line('.')+05,'  ; Legend:')
call append(line('.')+06,'  ;   W: 0 = above sufficient')
call append(line('.')+07,'  ;      1 = other differences exist')
call append(line('.')+08,'  ;   I: Interpreter:')
call append(line('.')+09,'  ;      0 = pre-incrementing')
call append(line('.')+10,'  ;      1 = post-incrementing')
call append(line('.')+11,'  ;   E: Address must be even:')
call append(line('.')+12,'  ;      0 = yes')
call append(line('.')+13,'  ;      1 = no')
call append(line('.')+14,'  ;   B: High byte @:')
call append(line('.')+15,'  ;      0 = low address')
call append(line('.')+16,'  ;      1 = high address')
call append(line('.')+17,'  ;   A: CPU address:')
call append(line('.')+18,'  ;      0 = byte')
call append(line('.')+19,'  ;      1 = word')

function! TidyRuler(heading)

  " Add a ruler above a heading.

  if search('^\s\+; '.a:heading.'$','wc')
    " XXX FIXME -- Why the comments are duplicated?
    " call append(line('.')-1,'  ; '.repeat('-',64))
  else
    echoerr 'Heading not found'
    wq!
  endif

endfunction

call TidyRuler('User variables')
call TidyRuler('Parameter area')
call TidyRuler('User variables init values')
call TidyRuler('Interpreter')
call TidyRuler('Dictionary')

" --------------------------------------------------------------
" Tidy the tape headers.

" %s@^tape_\(load\|save\)_header_length:$@&\r  ; XXX FIXME -- It should be 0x2C00.@
%s@^\(tape_\(load\|save\)_header:\)\_.\{-}\ntape_\2@\r\1\r  defb 3 ; filetype: code file\r  defb "DISC      " ; filename\rtape_\2@

" --------------------------------------------------------------
" Add symbols that are needed by <abersoft_forth.disassembled.z80s> but can not
" be included in <z80dasm_symbols.z80s> because they are not used in
" <abersoft_forth.disassembled.raw.z80s>.

call cursor(1,1)
call search('^\s\+org\>')
call append(line('.'),'precedence_bit: equ 0x40')

" --------------------------------------------------------------
" Add symbols whose values appear only in compiled literals in Forth words.

call append(line('.'),'sys_coordx: equ 0x5C7D')
call append(line('.'),'sys_coordy: equ 0x5C7E')
call append(line('.'),'sys_attr_p: equ 0x5C8D')
call append(line('.'),'sys_mask_p: equ 0x5C8E')
call append(line('.'),'sys_p_flag: equ 0x5C91')
call append(line('.'),'ram_disc_top: equ 0xFBFF')

%s,defw 0x5C7D$,defw sys_coordx,
%s,defw 0x5C7E$,defw sys_coordy,
%s,defw 0x5C8D$,defw sys_attr_p,
%s,defw 0x5C8E$,defw sys_mask_p,
%s,defw 0x5C91$,defw sys_p_flag,
%s,defw 0xFBFF$,defw ram_disc_top,

" --------------------------------------------------------------
" Add symbols whose values appear also in variables, constants or compiled
" literals, where they are not substituted by the disassembler.

%s,defw 0x5E6A$,defw pushde,
%s,defw 0x5E6B$,defw pushhl,

%s,defw 0xD000$,defw ram_disc_bottom,

" --------------------------------------------------------------
" Sort the symbols.

call cursor(1,1)
call search('^\s\+org\>')
call append(line('.'),'')
+2,/^$/-1 sort

" --------------------------------------------------------------
" Convert the name fields.

source tidy_name_fields.vim

" --------------------------------------------------------------
" Tidy the branches.

source tidy_branches.vim

" --------------------------------------------------------------
" Remove the comment addresses of branch words that are not actual branches,
" but compiled by `compile`.

%s@\(defw compile_cfa\)\n\s\+defw \S\+ ; 0x[0-9A-F]\{4}$@\1@

" --------------------------------------------------------------
" Tidy the strings

function! TidyString(length,first_letter,new_string)
  " length = length of the string, as an hex string
  " first_letter = first letter of the string, as an hex string
  if search('^\s\+defw paren_dot_quote_cfa\n\s\+defb '.a:length.'\n\s\+defb '.a:first_letter,'wc')
    s@^\(\s\+defw paren_dot_quote_cfa\)\n\(\s\+defb 0x[0-9A-B]\{2}\n\)\+@\1\r@
	" XXX FIXME
    if a:first_letter=='0x7F'
      " The copyright sign needs special representation.
      call append(line('.')+1,'  defb '.a:length.",".a:first_letter.",\"".a:new_string.'"')
    else
      call append(line('.')+1,'  defb '.a:length.",\"".a:new_string.'"')
    endif
  else
    echoerr 'String not found'
    wq!
  endif
endfunction

call TidyString('0x02','0x3F','? ')
call TidyString('0x02','0x6F','ok')
call TidyString('0x0E','0x66','fig-FORTH 1.1A')
call TidyString('0x0F','0x7F',' Abersoft:1983')
call TidyString('0x06','0x4D','MSG # ')
call TidyString('0x06','0x53','SCR # ') " in `LIST`
call TidyString('0x0D','0x34','48K SPECTRUM ')
call TidyString('0x06','0x53','SCR # ') " in `WHERE`

" --------------------------------------------------------------
" Add the header.

call setline(1,'; Abersoft Forth disassembled')
call append(1,'; in 2015 by Marcos Cruz (programandala.net)')
call append(2,'; http://programandala.net/en.program.abersoft_forth.html')
call append(3,'')

