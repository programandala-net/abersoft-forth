" tidy_z80.vim

" This Vim program tidies the Z80 source created by z80dasm.

" This file is part of
"   Abersoft Forth disassembled
"   http://programandala.net/en.program.abersoft_forth.html
"

" --------------------------------------------------------------
" History

" 2015-05-26: Start.


" --------------------------------------------------------------
" No default comments.

silent %s@^;.\+\n@@

" --------------------------------------------------------------
" No address and dump at the end of the lines, except the address of the branch
" words, that are preserved in order to add labels to the branches.

silent %s@\(defw \(zero_branch\|branch\|paren_loop\|paren_plus_loop\)_cfa\)_first\s\+;\([0-9a-f]\{4}\) [0-9a-f]\{2}.\+$@\1 ; 0x\U\3@

silent %s@\s\+;[0-9a-f]\{4} [0-9a-f]\{2}.\+$@@

" --------------------------------------------------------------
" Format of the hex numbers.

silent %s@\<0x\([0-9a-f]\+\)\>@0x\U\1@g
silent %s@\<0\([0-9a-f]\+\)h\>@0x\U\1@g

" --------------------------------------------------------------
" Zone labels that can be removed.

" XXX OLD
" %s@^\S\+_XXX_TMP_\(first\|last\|end\):\n@@

" --------------------------------------------------------------
" Labels that must be renamed to preserve them.

%s@\<colon_pfa100_first\>@do_colon@
%s@\<constant_pfa100_first\>@do_constant@
%s@\<user_pfa100_first\>@do_user@
%s@\<two_variable_pfa100_first\>@do_two_variable@
%s@\<does_pfa100_first\>@do_does@
%s@\<variable_pfa100_first\>@do_variable@

" --------------------------------------------------------------
" No end of zone labels.

silent %s@^\S\+_\(last\|end\):\n@@

" --------------------------------------------------------------
" No literal or string labels.

silent %s@^\(literal\|string\)_at_0x.\+:\n@@

" --------------------------------------------------------------
" No secondary pfa zones.

silent %s@^[a-z0-9_]\+pfa\d\+_first:\n@@

" --------------------------------------------------------------
" No '_first' suffixes.

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
call search('equ 0x5C7')
call append(line('.'),'sys_udg: equ 0x5C7B')
,+2 sort

" --------------------------------------------------------------
" No empty lines.

silent %s@\n\n\+@\r@

" --------------------------------------------------------------
" Some comments and separation lines.

silent %s@defw 0xA081@& ; Dummy name field.@g

call search('^cpu_name:')
call append(line('.'),'  ; CPU name stored as a 32-bit base 36 integer.')
call append(line('.')+1,'  ; XXX FIXME -- The used number 0x0005B320 is "8080" in base 36,')
call append(line('.')+2,'  ; and it should be 0x0000B250 ("Z80" in base 36).')

call search('^fig_user_version:')
call append(line('.'),'  ; XXX FIXME -- It should be 0x41 ("A").')

%s@^  defw 0x2BFF$@& ; XXX FIXME -- It should be 0x2C00.@

%s@^exit_pfa:\n\s\+defw to_r_cfa$@& ; XXX FIXME -- Serious bug: It should be `R>` (r_from_cfa), not `>R` (to_r_cfa).@

%s@\(^\s\+defw semicolon_s_cfa\)\n\s\+ld c,b\n\s\+ld h,c@\1\r\1 ; XXX FIXME --  Unnecessary duplicated code.@

%s@^origin:$@\r\r\r&\r\r  ; Unused zone@

%s@^hld_value:\n\s\+defw \S\+$@&\r\r  ; Unused zone@

%s@^s0_value:@\r  ; User variables\r&@

%s@^init_s0_value:@\r  ; User variables init values\r&@

call cursor(1,1)
call search('^origin:')
call append(line('.')-1,'')

call search('^cold_entry:')
call append(line('.')-1,['','  ; Entry points',''])

call search('^fig_release:')
call append(line('.')-1,'')

call cursor(1,1)
call search('^cpu_name:')
call append(line('.')-1,'')

call search('^pushde:')
call append(line('.')-1,['','  ; Interpreter',''])

call search('^lit_nfa:')
call append(line('.')-1,['','  ; Dictionary',''])

" --------------------------------------------------------------
" Tape headers.

" %s@^tape_\(load\|save\)_header_length:$@&\r  ; XXX FIXME -- It should be 0x2C00.@
%s@^\(tape_\(load\|save\)_header:\)\_.\{-}\ntape_\2@\r\1\r  defb 3 ; filetype: code file\r  defb "DISC      " ; filename\rtape_\2@

" --------------------------------------------------------------
" Symbols that are needed by <abersoft_forth.disassembled.z80s> but can not be
" included in <z80dasm_symbols.z80s> because they are not used in
" <abersoft_forth.disassembled.raw.z80s>.

call cursor(1,1)
call search('^\s\+org\>')
call append(line('.'),'precedence_bit: equ 0x40')

" --------------------------------------------------------------
" Symbols whose values appear only in compiled literals in Forth words.

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
" Symbols whose values appear also in variables, constants or compiled literals,
" where they are not substituted by the disassembler.

%s,defw 0x5E6A$,defw pushde,
%s,defw 0x5E6B$,defw pushhl,

%s,defw 0xD000$,defw ram_disc_bottom,

" --------------------------------------------------------------
" Sort the symbols.

call cursor(1,1)
call search('^\s\+org\>')
+1,/^origin:/-1 sort

" --------------------------------------------------------------
" Convert the name fields.

source tidy_name_fields.vim

" --------------------------------------------------------------
" Convert the branches. 

" XXX INFORMER
echo "About to source tidy_branches.vim"

source tidy_branches.vim

" --------------------------------------------------------------
" Add the header.

call setline(1,'; Abersoft Forth disassembled')
call append(1,'; by Marcos Cruz (programandala.net)')
call append(2,'; 2015-05')
call append(3,'; http://programandala.net/en.program.abersoft_forth.html')
call append(4,'')

