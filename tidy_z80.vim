" tidy_z80.vim

" This Vim program tidies the Z80 source created by z80dasm.

" This file is part of
"   Abersoft Forth disassembled
"   http://programandala.net/en.program.abersoft_forth_disassembled.html
"

" 2015-05-26: Start.

" No comments.

silent %s@^;.\+\n@@

" No address and dump at the end of the lines.

silent %s@\s\+;[0-9a-f]\{4} [0-9a-f]\{2}.\+$@@

" Format of the hex numbers.

silent %s@\<0x\([0-9a-f]\+\)\>@0x\U\1@g
silent %s@\<0\([0-9a-f]\+\)h\>@0x\U\1@g

" Zone labels that can be removed.

%s@^\S\+_XXX_TMP_\(first\|last\|end\):\n@@

" Labels that must be renamed to preserve them.

%s@\<colon_pfa100_first\>@do_colon@
%s@\<constant_pfa100_first\>@do_constant@
%s@\<user_pfa100_first\>@do_user@
%s@\<two_variable_pfa100_first\>@do_two_variable@
%s@\<does_pfa100_first\>@do_does@
%s@\<variable_pfa100_first\>@do_variable@

" No end of zone labels.

silent %s@^\S\+_\(last\|end\):\n@@

" No literal or string labels.

silent %s@^\(literal\|string\)_at_0x.\+:\n@@

" No secondary pfa zones.

silent %s@^[a-z_]\+pfa\d\+_first:\n@@

" No '_first' suffixes.

silent %s@\<\([a-z_]\+\)_first@\1@

" Remove the tail after the last label.

silent /^l8159h:$/+1,$s@\_.\+@@

" Rename some automatic labels.

silent %s@\<l8159h\>@dictionary_pointer_after_cold@g

" Rename numbers that z80dasm could not convert
" to symbols because they appear in compiled literals,
" thus in worddata blocks.

silent %s@\<0x5C7B\>@sys_udg@g
call cursor(1,1)
call search('equ 0x5C7')
call append(line('.'),'sys_udg: equ 0x5C7B')
,+2 sort

" Some comments.

silent %s@defw 0xA081@& ; Dummy name field.@g

call search('^z80_cpu_name:')
call append(line('.'),'  ; CPU name stored as a 32-bit base 36 integer:')
call append(line('.')+1,'  ; The used number 0x0005B320 is "8080" in base 36,')
call append(line('.')+2,'  ; and it should be 0x0000B250 ("Z80" in base 36).')

call search('^fig_user_version:')
call append(line('.'),'  ; It should be 0x41 ("A").')

" No empty lines.

silent %s@\n\n\+@\r@

" Header.

call append(1,'; Abersoft Forth disassembled')
call append(2,'; by Marcos Cruz (programandala.net)')
call append(3,'; http://programandala.net/en.program.abersoft_forth_disassembled.html')
call append(4,'')

