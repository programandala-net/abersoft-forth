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
" 2015-06-01: Strings are tidied. Trace.
" 2015-06-07: One more note added to the disassembled source.
" 2015-06-08: More notes added to the disassembled source
" (about the optimization of color words).
" 2015-06-19: Notes about the `0 MESSAGE` bug, recently discovered during
" the development of Solo Forth.
" 2015-06-23: Notes about `jp pushde` optimizations.
" 2015-06-24: Notes about optimization in `j` and `(do)`.
" 2015-08-14: Notes about `ld hl,(init_s0_value)`; `ld c,0x00` in `INKEY`; `;S`
" in `WHERE`.
" 2015-09-03: Divided some comments that were longer than 80 characters.

" --------------------------------------------------------------
" Trace

let s:trace=0 " flag
let s:tracePath='./' " path with trailing slash
let s:traceBaseFilename='abersoft_forth.disassembled.step_'
let s:traceStep=0 " counter
silent execute '!rm -f '.s:tracePath.s:traceBaseFilename.'*.z80s'

function! TidyTrace(description)

  if s:trace

    let l:number='00'.s:traceStep
    let l:number=strpart(l:number,len(l:number)-2)
    execute 'write! '.s:tracePath.s:traceBaseFilename.l:number.'_'.a:description.'.z80s'
    let s:traceStep=s:traceStep+1

  endif

endfunction

" --------------------------------------------------------------
" No default comments.

silent %s@^;.\+\n@@

" --------------------------------------------------------------
" Remove addresses and dump bytes at the end of the lines, except the address
" of the branch words, that are preserved in order to add labels to the
" branches.

silent %s@\(defw \(zero_branch\|branch\|paren_loop\|paren_plus_loop\)_cfa\)_first\s\+;\([0-9a-f]\{4}\) [0-9a-f]\{2}.\+$@\1 ; 0x\U\3@

silent %s@\s\+;[0-9a-f]\{4} [0-9a-f]\{2}.\+$@@

call TidyTrace('no_comments')

" --------------------------------------------------------------
" Change the format of hex numbers.

silent %s@\<0x\([0-9a-f]\+\)\>@0x\U\1@g
silent %s@\<0\([0-9a-f]\+\)h\>@0x\U\1@g

call TidyTrace('hex_numbers')

" --------------------------------------------------------------
" Rename labels that must be preserved.

%s@\<colon_pfa100_first\>@do_colon@
%s@\<constant_pfa100_first\>@do_constant@
%s@\<user_pfa100_first\>@do_user@
%s@\<two_variable_pfa100_first\>@do_two_variable@
%s@\<does_pfa100_first\>@do_does@
%s@\<variable_pfa100_first\>@do_variable@

call TidyTrace('do_labels')

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
" therefore in worddata blocks.

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

%s@^exit_pfa:\n\s\+defw to_r_cfa$@& ; XXX FIXME -- Serious bug: It should be `R>` (from_r_cfa),\r                ;              not `>R` (to_r_cfa).@

%s@^\s\+defw noop_cfa\n\s\+defw noop_cfa$@; XXX FIXME -- These useless `noop` can be removed, they are a patch to overwrite a bell in the original fig-Forth implementation:\r&@

%s@\(^\s\+defw semicolon_s_cfa\)\n\s\+ld c,b\n\s\+ld h,c@\1\r\1 ; XXX FIXME --  Unnecessary duplicated code.@

%s@^\s\+defb 0x[0-9A-F]\{2}\n\s\+nop$@& ; XXX FIXME -- Unnecessary.@

%s@^\s\+push hl\n\s\+jp next$@  ; XXX FIXME -- Optimize: `jp pushhl`:\r&@

%s@^\s\+defw over_cfa\n\s\+defw over_cfa$@  ; XXX FIXME -- Optimize: `2DUP` instead of `OVER OVER`:\r&@

%s@^\(rp\|sp\)_store_pfa:$@&\r  ; XXX FIXME -- Optimize: no need to use the DE register:@

%s@^  push de\n  jp pushhl@  ; XXX FIXME -- Optimize: `jp pushde` instead of `push de` and `jp pushhl`:\r&@

%s@^cold_pfa:$@&\r  ; XXX FIXME -- `FIRST` should be used instead of compiled literals with its value:@

%s@^paren_line_pfa:$@&\r  ; XXX FIXME -- `C/L` should be used instead of the compiled literals (0x0040):@

%s@^origin:$@\r  ; Parameter area\r\r&\r@

%s@^hld_value:\n\s\+defw \S\+$@&\r  ; Unused@

%s@^user_variables_origin:@\r  ; User variables\r\r&\r\r  ; Unused@

%s@^init_s0_value:@\r  ; User variables init values\r\r&@

%s@^user_pointer_value:$@\r&@

%s@^init_user_pointer_value:$@&\r  ; XXX NOTE: The fig-Forth model uses this in `COLD`,\r  ;           but Abersoft Forth doesn't.@

%s@^\(flash\|bright\|gover\|inverse\)_pfa:$@&\r  ; XXX FIXME -- Only one store operation is needed, at the end,\r  ;              what saves 6 bytes without speed penalty.@
%s@^\(gover\|inverse\)_pfa:$@&\r  ; XXX FIXME -- The final store operations should be `C!`, not `!`,\r  ;              else the next system variable, MEMBOT, is affected.@

%s@^question_terminal_pfa:\n\s\+ld hl,0x0000$@& ; XXX FIXME -- This command is unnecessary.@
call search('^question_terminal_routine:$','wc')
call append(line('.'),'  ; XXX FIXME -- Saving and restoring the DE and BC registers is unnecessary.')

call search('^j_pfa:$','wc')
call append(line('.')+1,'  ; XXX FIXME -- Optimize:')
call append(line('.')+2,'  ;              `ld hl,4 / add hl,de` is faster than four `inc hl`,')
call append(line('.')+3,'  ;              and the same size.')

call search('^paren_do_pfa:$','wc')
call append(line('.')+1,'  ; XXX FIXME -- Optimize:')
call append(line('.')+2,'  ;              `ld hl,-4 / add hl,de` is faster than four `dec hl`,')
call append(line('.')+3,'  ;              and the same size.')
call append(line('.')+4,'  ;              But the code of CP/M fig-Forth 1.1g is a bit better.')

call search('^cold_entry:','wc')
call append(line('.')-1,'  ; Entry points')

call search('^fig_release:','wc')
call append(line('.')-1,'')

call search('^cpu_name:','wc')
call append(line('.')-1,'')

call search('^warm_start:','wc')
call append(line('.')-1,'')

call search('^cold_start:','wc')
call append(line('.')-1,'')

call search('^link_status:','wc')
call append(line('.')-1,'')

call search('^mon_pfa:','wc')
call append(line('.')+0,'  ; XXX FIXME -- Checking NMIADD (undocumented feature)')
call append(line('.')+1,'  ;              is not compatible with ZX Spectrum +3.')
call append(line('.')+3,'  ; XXX FIXME -- This code wastes 3 bytes.')

call search('^pushde:','wc')
call append(line('.')-1,['','  ; Interpreter',''])

call search('^lit_nfa:','wc')
call append(line('.')-1,['','  ; Dictionary'])

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

call search('^question_terminal_routine:$','wc')
call append(line('.')-1,'')

call search('^cr_routine:$','wc')
call append(line('.')-1,'')

call search('^key_routine:$','wc')
call append(line('.')-1,'')

call search('^key_routine_cursor_char:$','wc')
call append(line('.')-1,'')

call search('^printer_channel_or_zero:$','wc')
call append(line('.')-1,'')

call search('^paren_emit_cfa:$','wc')
call append(line('.')-1,'')

call search('^dictionary_pointer_after_cold:$','wc')
call append(line('.')-1,'')
call append(line('.'),['','end cold_entry'])

call search('^message_pfa:$','wc')
call append(line('.')+04,'  ; XXX FIXME --')
call append(line('.')+05,'  ; Because of the conditional branch below, error message 0')
call append(line('.')+06,'  ; is not printed when `WARNING` is 1, in other words:')
call append(line('.')+07,'  ; when error messages are the text of a line relative to screen 4.')
call append(line('.')+08,'  ; This condition is in other fig-Forth implementations,')
call append(line('.')+09,'  ; but in Abersoft Forth it is a bug,')
call append(line('.')+10,'  ; because error 0 is used by the system: "Word not found".')

call cursor(1,1)
while search('^  ld hl,(init_s0_value)\n  ld sp,hl','W')
  call append(line('.')-1,'  ; XXX FIXME --  `ld sp,(init_s0_value)` can be used instead:')
endwhile

" Useless Z80 instruction in `INKEY`
%s@ld c,0x00@& ; XXX FIXME --  useless instruction@

" Useless `QUIT` at the end of `WHERE`
%s@defw editor_cfa\n  defw quit_cfa@& ; XXX FIXME -- useless, because `ERROR` already executed it@

call TidyTrace('new_comments')

function! TidyRuler(heading)

  " Add a ruler above a heading.

  if search('^\s\+; '.a:heading.'$','wc')
    " XXX FIXME -- Why the comments are duplicated?
    call append(line('.')-1,'  ; '.repeat('-',64))
  else
    echoerr 'Heading not found'
    quit!
  endif

endfunction

call TidyRuler('User variables')
call TidyRuler('Parameter area')
call TidyRuler('User variables init values')
call TidyRuler('Interpreter')
call TidyRuler('Dictionary')

call TidyTrace('rulers')

" --------------------------------------------------------------
" Tidy the tape headers.

" %s@^tape_\(load\|save\)_header_length:$@&\r  ; XXX FIXME -- It should be 0x2C00.@
%s@^\(tape_\(load\|save\)_header:\)\_.\{-}\ntape_\2@\r\1\r  defb 3 ; filetype: code file\r  defb "DISC      " ; filename\rtape_\2@

call TidyTrace('tape_headers')

" --------------------------------------------------------------
" Add symbols that are needed by <abersoft_forth.disassembled.z80s> but can not
" be included in <z80dasm_symbols.z80s> because they are not used in
" <abersoft_forth.disassembled.raw.z80s>.

call cursor(1,1)
call search('^\s\+org\>')
call append(line('.'),'precedence_bit_mask: equ 0x40')

" --------------------------------------------------------------
" Add symbols whose values appear only in compiled literals in Forth words.

call append(line('.'),'smudge_bit_mask: equ 0x20')
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

%s,defw lit_cfa\n\s\+defw 0x0020\n\s\+defw toggle_cfa$,defw lit_cfa\r\  defw smudge_bit_mask\r  defw toggle_cfa,

" --------------------------------------------------------------
" Add symbols whose values appear also in variables, constants or compiled
" literals, where they are not substituted by the disassembler.

%s,defw 0x5E40$,defw origin,
%s,defw 0x5E4C$,defw top_most_word_in_forth_voc,
%s,defw 0x5E52$,defw init_s0_value,
%s,defw 0x5E66$,defw user_pointer_value,
%s,defw 0x5E6A$,defw pushde,
%s,defw 0x5E6B$,defw pushhl,
%s,defw 0x5E6C$,defw next,

%s,defw 0x6CF8$,defw forth_vocabulary_latest,

" %s,defw 0xCB40$,defw data_stack_bottom, " XXX OLD
%s,defw 0xCBE0$,defw first_buffer,

%s,defw 0xD000$,defw ram_disc_bottom,

" --------------------------------------------------------------
" Sort the symbols.

call cursor(1,1)
call search('^\s\+org\>')
+1,/^$/-1 sort
call append(line('.')-1,'')

call TidyTrace('new_symbols')

" --------------------------------------------------------------
" Adjust `?STACK`

" During the execution of the self-disassembling tools, `?STACK` has already
" been patched by the Afera library module <lowersys.fsb>. Though the patch is
" modified by <patches.fsb>, and its apparent size is the same than the
" original, the `LIT` of its definition were overwritten by the first patch,
" what causes the tools can not create the proper symbols and zones.
"
" The following commands fix the disassembling of `?STACK`.

/^question_stack_nfa:$/,/^interpret_nfa:$/ s@defw 0x5E7D\n\s\+defw 0x0080$@defw lit_cfa,0x0080@
/^question_stack_nfa:$/,/^interpret_nfa:$/ s@defw 0x656F$@defw u_less_than_cfa@

" --------------------------------------------------------------
" Convert the name fields.

source tidy_name_fields.vim

call TidyTrace('name_fields')

" --------------------------------------------------------------
" Tidy the branches.

source tidy_branches.vim

call TidyTrace('branches')

" --------------------------------------------------------------
" Remove the comment addresses of branch words that are not actual branches,
" but compiled by `compile`.

%s@\(defw compile_cfa\n\s\+defw \S\+\) ; 0x[0-9A-F]\{4}$@\1@

" --------------------------------------------------------------
" Tidy the strings

function! TidyString(length,first_letter,new_string)
  " length = length of the string, as an hex string
  " first_letter = first letter of the string, as an hex string
  if search('^\s\+defw paren_dot_quote_cfa\n\s\+defb '.a:length.'\n\s\+defb '.a:first_letter,'wc')
    call cursor(line('.')+1,1)
    while match(getline(line('.')),'^\s\+defb 0x[0-9A-F]\{2}$')==0
      " Delete the current line.
      normal dd
    endwhile
    if a:first_letter=='0x7F'
      " The copyright sign needs special representation.
      call append(line('.')-1,'  defb '.a:length.",".a:first_letter.",\"".a:new_string.'"')
    else
      call append(line('.')-1,'  defb '.a:length.",\"".a:new_string.'"')
    endif
  else
    echoerr 'String not found'
    quit!
  endif
endfunction

call TidyString('0x02','0x3F','? ')             " in `ERROR`
call TidyString('0x02','0x6F','ok')             " in `QUIT`
call TidyString('0x0E','0x66','fig-FORTH 1.1A') " in `ABORT`
call TidyString('0x0F','0x7F',' Abersoft:1983') " in `ABORT`
call TidyString('0x06','0x4D','MSG # ')         " in `MESSAGE`
call TidyString('0x06','0x53','SCR # ')         " in `LIST`
call TidyString('0x0D','0x34','48K SPECTRUM ')  " in `.CPU`
call TidyString('0x06','0x53','SCR # ')         " in `WHERE`

call TidyTrace('strings')

" --------------------------------------------------------------
" Tidy the RST calls

%s@\<rst 10h\>@rst 0x10@
%s@\<rst 8\>@rst 0x08@

" --------------------------------------------------------------
" Tidy the compiled literals.

%s@^\(\s\+defw lit_cfa\)\n\s\+defw \(sys_\S\+\|ram_\S\+\|0x[0-9A-F]\+.*\|origin\|\S\+_value\|first_buffer\|top_most_word\S\+\|forth_vocabulary_latest\|smudge_bit_mask\)$@\1,\2@

call TidyTrace('literal')

" --------------------------------------------------------------
" Add the header.

call setline(1,'; ZX Spectrum Abersoft Forth')
call append(1,'; Disassembled by Marcos Cruz (programandala.net), 2015')
call append(2,'; http://programandala.net/en.program.abersoft_forth.html')
call append(3,'; Original program by John Jones-Steel, 1983')
call append(4,'; http://www.worldofspectrum.org/infoseekid.cgi?id=0008178')
call append(5,'')

" --------------------------------------------------------------
" Remove empty lines.

silent %s@\n\n\n\+@\r\r@

