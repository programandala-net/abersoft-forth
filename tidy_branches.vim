
" This file was automatically created by AbersoftForth2branches
" This file is part of Abersoft Forth disassembled
" By Marcos Cruz (programandala.net), 2015
" http://programandala.net/en.program.abersoft_forth.html



" Branch word at 0x7A6A in FIND 
if search('defw zero_branch_cfa\s;\s0x7A6A\n\s\+defw 0x0012$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0012\)$`\1,\2 ; to branch_destination_0x7A7E`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7A80 in FIND 
if search('defw zero_branch_cfa\s;\s0x7A80\n\s\+defw 0xFFDE$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFDE\)$`\1,\2 ; to branch_destination_0x7A60`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7A15 in MATCH 
if search('defw zero_branch_cfa\s;\s0x7A15\n\s\+defw 0x001A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001A\)$`\1,\2 ; to branch_destination_0x7A31`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7A31 in MATCH 
if search('defw paren_loop_cfa\s;\s0x7A31\n\s\+defw 0xFFDC$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFDC\)$`\1,\2 ; to branch_destination_0x7A0F`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x79BF in -TEXT 
if search('defw zero_branch_cfa\s;\s0x79BF\n\s\+defw 0x002A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x002A\)$`\1,\2 ; to branch_destination_0x79EB`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x79D5 in -TEXT 
if search('defw zero_branch_cfa\s;\s0x79D5\n\s\+defw 0x000A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x79E1`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x79DD in -TEXT 
if search('defw branch_cfa\s;\s0x79DD\n\s\+defw 0x0004$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x79E3`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x79E3 in -TEXT 
if search('defw paren_loop_cfa\s;\s0x79E3\n\s\+defw 0xFFE6$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFE6\)$`\1,\2 ; to branch_destination_0x79CB`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x79E7 in -TEXT 
if search('defw branch_cfa\s;\s0x79E7\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x79EF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x79A7 in COPY 
if search('defw paren_loop_cfa\s;\s0x79A7\n\s\+defw 0xFFEE$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFEE\)$`\1,\2 ; to branch_destination_0x7997`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x796E in CLEAR 
if search('defw paren_loop_cfa\s;\s0x796E\n\s\+defw 0xFFFA$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFFA\)$`\1,\2 ; to branch_destination_0x796A`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x78C0 in D 
if search('defw paren_loop_cfa\s;\s0x78C0\n\s\+defw 0xFFF4$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF4\)$`\1,\2 ; to branch_destination_0x78B6`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x789A in S 
if search('defw paren_plus_loop_cfa\s;\s0x789A\n\s\+defw 0xFFF0$','wc')
  silent s`\(defw paren_plus_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF0\)$`\1,\2 ; to branch_destination_0x788C`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x80FA in ENDCASE 
if search('defw zero_branch_cfa\s;\s0x80FA\n\s\+defw 0x000A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x8106`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x8102 in ENDCASE 
if search('defw branch_cfa\s;\s0x8102\n\s\+defw 0xFFEC$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFEC\)$`\1,\2 ; to branch_destination_0x80F0`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7FF8 in DRAW 
if search('defw zero_branch_cfa\s;\s0x7FF8\n\s\+defw 0x0012$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0012\)$`\1,\2 ; to branch_destination_0x800C`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x8008 in DRAW 
if search('defw branch_cfa\s;\s0x8008\n\s\+defw 0x000A$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x8014`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x801E in DRAW 
if search('defw zero_branch_cfa\s;\s0x801E\n\s\+defw 0x0012$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0012\)$`\1,\2 ; to branch_destination_0x8032`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x802E in DRAW 
if search('defw branch_cfa\s;\s0x802E\n\s\+defw 0x000A$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x803A`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x806E in DRAW 
if search('defw paren_loop_cfa\s;\s0x806E\n\s\+defw 0xFFD8$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFD8\)$`\1,\2 ; to branch_destination_0x8048`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7E81 in INVERSE 
if search('defw zero_branch_cfa\s;\s0x7E81\n\s\+defw 0x0018$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0018\)$`\1,\2 ; to branch_destination_0x7E9B`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7E97 in INVERSE 
if search('defw branch_cfa\s;\s0x7E97\n\s\+defw 0x0014$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x7EAD`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7E49 in GOVER 
if search('defw zero_branch_cfa\s;\s0x7E49\n\s\+defw 0x0016$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0016\)$`\1,\2 ; to branch_destination_0x7E61`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7E5D in GOVER 
if search('defw branch_cfa\s;\s0x7E5D\n\s\+defw 0x0014$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x7E73`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7E11 in BRIGHT 
if search('defw zero_branch_cfa\s;\s0x7E11\n\s\+defw 0x0018$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0018\)$`\1,\2 ; to branch_destination_0x7E2B`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7E27 in BRIGHT 
if search('defw branch_cfa\s;\s0x7E27\n\s\+defw 0x0014$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x7E3D`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7DD8 in FLASH 
if search('defw zero_branch_cfa\s;\s0x7DD8\n\s\+defw 0x0018$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0018\)$`\1,\2 ; to branch_destination_0x7DF2`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7DEE in FLASH 
if search('defw branch_cfa\s;\s0x7DEE\n\s\+defw 0x0014$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x7E04`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7D42 in INK 
if search('defw zero_branch_cfa\s;\s0x7D42\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x7D4C`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7D48 in INK 
if search('defw branch_cfa\s;\s0x7D48\n\s\+defw 0x0082$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0082\)$`\1,\2 ; to branch_destination_0x7DCC`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7D54 in INK 
if search('defw zero_branch_cfa\s;\s0x7D54\n\s\+defw 0x001A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001A\)$`\1,\2 ; to branch_destination_0x7D70`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7D6C in INK 
if search('defw branch_cfa\s;\s0x7D6C\n\s\+defw 0x005E$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x005E\)$`\1,\2 ; to branch_destination_0x7DCC`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7D78 in INK 
if search('defw zero_branch_cfa\s;\s0x7D78\n\s\+defw 0x001A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001A\)$`\1,\2 ; to branch_destination_0x7D94`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7D90 in INK 
if search('defw branch_cfa\s;\s0x7D90\n\s\+defw 0x003A$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x003A\)$`\1,\2 ; to branch_destination_0x7DCC`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7C55 in PAPER 
if search('defw zero_branch_cfa\s;\s0x7C55\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x7C5F`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7C5B in PAPER 
if search('defw branch_cfa\s;\s0x7C5B\n\s\+defw 0x0088$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0088\)$`\1,\2 ; to branch_destination_0x7CE5`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7C67 in PAPER 
if search('defw zero_branch_cfa\s;\s0x7C67\n\s\+defw 0x001A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001A\)$`\1,\2 ; to branch_destination_0x7C83`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7C7F in PAPER 
if search('defw branch_cfa\s;\s0x7C7F\n\s\+defw 0x0064$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0064\)$`\1,\2 ; to branch_destination_0x7CE5`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7C8B in PAPER 
if search('defw zero_branch_cfa\s;\s0x7C8B\n\s\+defw 0x001A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001A\)$`\1,\2 ; to branch_destination_0x7CA7`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7CA3 in PAPER 
if search('defw branch_cfa\s;\s0x7CA3\n\s\+defw 0x0040$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0040\)$`\1,\2 ; to branch_destination_0x7CE5`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7BE8 in AT 
if search('defw zero_branch_cfa\s;\s0x7BE8\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x7BF2`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7BEE in AT 
if search('defw branch_cfa\s;\s0x7BEE\n\s\+defw 0x0022$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0022\)$`\1,\2 ; to branch_destination_0x7C12`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7BFE in AT 
if search('defw zero_branch_cfa\s;\s0x7BFE\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x7C08`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7C04 in AT 
if search('defw branch_cfa\s;\s0x7C04\n\s\+defw 0x000C$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000C\)$`\1,\2 ; to branch_destination_0x7C12`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x778F in TRIAD 
if search('defw zero_branch_cfa\s;\s0x778F\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x7795`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7795 in TRIAD 
if search('defw paren_loop_cfa\s;\s0x7795\n\s\+defw 0xFFF0$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF0\)$`\1,\2 ; to branch_destination_0x7787`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x775D in INDEX 
if search('defw zero_branch_cfa\s;\s0x775D\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x7763`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7763 in INDEX 
if search('defw paren_loop_cfa\s;\s0x7763\n\s\+defw 0xFFE6$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFE6\)$`\1,\2 ; to branch_destination_0x774B`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x758D in LIST 
if search('defw zero_branch_cfa\s;\s0x758D\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x7593`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7593 in LIST 
if search('defw paren_loop_cfa\s;\s0x7593\n\s\+defw 0xFFE2$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFE2\)$`\1,\2 ; to branch_destination_0x7577`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x752B in VLIST 
if search('defw zero_branch_cfa\s;\s0x752B\n\s\+defw 0x000A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x7537`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7549 in VLIST 
if search('defw zero_branch_cfa\s;\s0x7549\n\s\+defw 0xFFD0$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFD0\)$`\1,\2 ; to branch_destination_0x751B`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7494 in #S 
if search('defw zero_branch_cfa\s;\s0x7494\n\s\+defw 0xFFF4$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF4\)$`\1,\2 ; to branch_destination_0x748A`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x746F in # 
if search('defw zero_branch_cfa\s;\s0x746F\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x7479`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x744D in SIGN 
if search('defw zero_branch_cfa\s;\s0x744D\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x7457`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x740A in SPACES 
if search('defw zero_branch_cfa\s;\s0x740A\n\s\+defw 0x000C$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000C\)$`\1,\2 ; to branch_destination_0x7418`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7414 in SPACES 
if search('defw paren_loop_cfa\s;\s0x7414\n\s\+defw 0xFFFC$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFFC\)$`\1,\2 ; to branch_destination_0x7412`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x725B in FLUSH 
if search('defw paren_loop_cfa\s;\s0x725B\n\s\+defw 0xFFF8$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF8\)$`\1,\2 ; to branch_destination_0x7255`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7237 in R/W 
if search('defw zero_branch_cfa\s;\s0x7237\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x723D`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x71C7 in BLOCK 
if search('defw zero_branch_cfa\s;\s0x71C7\n\s\+defw 0x0034$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0034\)$`\1,\2 ; to branch_destination_0x71FD`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x71CF in BLOCK 
if search('defw zero_branch_cfa\s;\s0x71CF\n\s\+defw 0x0014$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x71E5`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x71F3 in BLOCK 
if search('defw zero_branch_cfa\s;\s0x71F3\n\s\+defw 0xFFD6$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFD6\)$`\1,\2 ; to branch_destination_0x71CB`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7171 in BUFFER 
if search('defw zero_branch_cfa\s;\s0x7171\n\s\+defw 0xFFFC$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFFC\)$`\1,\2 ; to branch_destination_0x716F`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x717F in BUFFER 
if search('defw zero_branch_cfa\s;\s0x717F\n\s\+defw 0x0014$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x7195`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x7146 in EMPTY-BUFFERS 
if search('defw paren_plus_loop_cfa\s;\s0x7146\n\s\+defw 0xFFF2$','wc')
  silent s`\(defw paren_plus_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF2\)$`\1,\2 ; to branch_destination_0x713A`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x70E7 in +BUF 
if search('defw zero_branch_cfa\s;\s0x70E7\n\s\+defw 0x0006$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x70EF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6F93 in MESSAGE 
if search('defw zero_branch_cfa\s;\s0x6F93\n\s\+defw 0x001E$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001E\)$`\1,\2 ; to branch_destination_0x6FB3`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6F99 in MESSAGE 
if search('defw zero_branch_cfa\s;\s0x6F99\n\s\+defw 0x0014$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x6FAF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6FAF in MESSAGE 
if search('defw branch_cfa\s;\s0x6FAF\n\s\+defw 0x000D$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000D\)$`\1,\2 ; to branch_destination_0x6FBE`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6E82 in MAX 
if search('defw zero_branch_cfa\s;\s0x6E82\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6E88`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6E6C in MIN 
if search('defw zero_branch_cfa\s;\s0x6E6C\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6E72`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6E3B in D+- 
if search('defw zero_branch_cfa\s;\s0x6E3B\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6E41`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6E29 in +- 
if search('defw zero_branch_cfa\s;\s0x6E29\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6E2F`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6D43 in QUIT 
if search('defw zero_branch_cfa\s;\s0x6D43\n\s\+defw 0x0007$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0007\)$`\1,\2 ; to branch_destination_0x6D4C`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6D4C in QUIT 
if search('defw branch_cfa\s;\s0x6D4C\n\s\+defw 0xFFE7$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFE7\)$`\1,\2 ; to branch_destination_0x6D35`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C5F in INTERPRET 
if search('defw zero_branch_cfa\s;\s0x6C5F\n\s\+defw 0x001E$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001E\)$`\1,\2 ; to branch_destination_0x6C7F`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C69 in INTERPRET 
if search('defw zero_branch_cfa\s;\s0x6C69\n\s\+defw 0x000A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x6C75`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C71 in INTERPRET 
if search('defw branch_cfa\s;\s0x6C71\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x6C79`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C7B in INTERPRET 
if search('defw branch_cfa\s;\s0x6C7B\n\s\+defw 0x001C$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x001C\)$`\1,\2 ; to branch_destination_0x6C99`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C89 in INTERPRET 
if search('defw zero_branch_cfa\s;\s0x6C89\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6C93`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C8F in INTERPRET 
if search('defw branch_cfa\s;\s0x6C8F\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x6C97`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C99 in INTERPRET 
if search('defw branch_cfa\s;\s0x6C99\n\s\+defw 0xFFC2$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFC2\)$`\1,\2 ; to branch_destination_0x6C5D`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6C16 in DLITERAL 
if search('defw zero_branch_cfa\s;\s0x6C16\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6C20`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6BF9 in LITERAL 
if search('defw zero_branch_cfa\s;\s0x6BF9\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6C03`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6B83 in CREATE 
if search('defw zero_branch_cfa\s;\s0x6B83\n\s\+defw 0x0010$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0010\)$`\1,\2 ; to branch_destination_0x6B95`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6B05 in ERROR 
if search('defw zero_branch_cfa\s;\s0x6B05\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6B0B`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6B20 in ERROR 
if search('defw zero_branch_cfa\s;\s0x6B20\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6B2A`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6AD7 in -FIND 
if search('defw zero_branch_cfa\s;\s0x6AD7\n\s\+defw 0x000A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x6AE3`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6A97 in NUMBER 
if search('defw zero_branch_cfa\s;\s0x6A97\n\s\+defw 0x0016$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0016\)$`\1,\2 ; to branch_destination_0x6AAF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6AAB in NUMBER 
if search('defw branch_cfa\s;\s0x6AAB\n\s\+defw 0xFFDC$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFDC\)$`\1,\2 ; to branch_destination_0x6A89`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6AB3 in NUMBER 
if search('defw zero_branch_cfa\s;\s0x6AB3\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6AB9`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6A30 in (NUMBER) 
if search('defw zero_branch_cfa\s;\s0x6A30\n\s\+defw 0x002C$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x002C\)$`\1,\2 ; to branch_destination_0x6A5E`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6A4E in (NUMBER) 
if search('defw zero_branch_cfa\s;\s0x6A4E\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6A58`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6A5A in (NUMBER) 
if search('defw branch_cfa\s;\s0x6A5A\n\s\+defw 0xFFC6$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFC6\)$`\1,\2 ; to branch_destination_0x6A22`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x69D5 in WORD 
if search('defw zero_branch_cfa\s;\s0x69D5\n\s\+defw 0x000C$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000C\)$`\1,\2 ; to branch_destination_0x69E3`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x69DF in WORD 
if search('defw branch_cfa\s;\s0x69DF\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x69E7`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x692D in  
if search('defw zero_branch_cfa\s;\s0x692D\n\s\+defw 0x002A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x002A\)$`\1,\2 ; to branch_destination_0x6959`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x694B in  
if search('defw zero_branch_cfa\s;\s0x694B\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6955`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6955 in  
if search('defw branch_cfa\s;\s0x6955\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x695D`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68AB in EXPECT 
if search('defw zero_branch_cfa\s;\s0x68AB\n\s\+defw 0x002A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x002A\)$`\1,\2 ; to branch_destination_0x68D7`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68C3 in EXPECT 
if search('defw zero_branch_cfa\s;\s0x68C3\n\s\+defw 0x000A$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x68CF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68CB in EXPECT 
if search('defw branch_cfa\s;\s0x68CB\n\s\+defw 0x0032$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0032\)$`\1,\2 ; to branch_destination_0x68FF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68D3 in EXPECT 
if search('defw branch_cfa\s;\s0x68D3\n\s\+defw 0x0028$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0028\)$`\1,\2 ; to branch_destination_0x68FD`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68DF in EXPECT 
if search('defw zero_branch_cfa\s;\s0x68DF\n\s\+defw 0x000E$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000E\)$`\1,\2 ; to branch_destination_0x68EF`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68EB in EXPECT 
if search('defw branch_cfa\s;\s0x68EB\n\s\+defw 0x0004$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x68F1`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x68FF in EXPECT 
if search('defw paren_loop_cfa\s;\s0x68FF\n\s\+defw 0xFF9C$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFF9C\)$`\1,\2 ; to branch_destination_0x689D`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x686A in ." 
if search('defw zero_branch_cfa\s;\s0x686A\n\s\+defw 0x0014$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0014\)$`\1,\2 ; to branch_destination_0x6880`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x687C in ." 
if search('defw branch_cfa\s;\s0x687C\n\s\+defw 0x000A$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000A\)$`\1,\2 ; to branch_destination_0x6888`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x682C in -TRAILING 
if search('defw zero_branch_cfa\s;\s0x682C\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6836`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6832 in -TRAILING 
if search('defw branch_cfa\s;\s0x6832\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x683A`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x683A in -TRAILING 
if search('defw paren_loop_cfa\s;\s0x683A\n\s\+defw 0xFFE0$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFE0\)$`\1,\2 ; to branch_destination_0x681C`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x67EA in TYPE 
if search('defw zero_branch_cfa\s;\s0x67EA\n\s\+defw 0x0018$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0018\)$`\1,\2 ; to branch_destination_0x6804`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x67FC in TYPE 
if search('defw paren_loop_cfa\s;\s0x67FC\n\s\+defw 0xFFF8$','wc')
  silent s`\(defw paren_loop_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF8\)$`\1,\2 ; to branch_destination_0x67F6`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6800 in TYPE 
if search('defw branch_cfa\s;\s0x6800\n\s\+defw 0x0004$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6806`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6668 in ?ERROR 
if search('defw zero_branch_cfa\s;\s0x6668\n\s\+defw 0x0008$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0008\)$`\1,\2 ; to branch_destination_0x6672`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x666E in ?ERROR 
if search('defw branch_cfa\s;\s0x666E\n\s\+defw 0x0004$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x6674`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x65E5 in TRAVERSE 
if search('defw zero_branch_cfa\s;\s0x65E5\n\s\+defw 0xFFF0$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0xFFF0\)$`\1,\2 ; to branch_destination_0x65D7`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x65C0 in -DUP 
if search('defw zero_branch_cfa\s;\s0x65C0\n\s\+defw 0x0004$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0004\)$`\1,\2 ; to branch_destination_0x65C6`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6577 in U< 
if search('defw zero_branch_cfa\s;\s0x6577\n\s\+defw 0x000C$','wc')
  silent s`\(defw zero_branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x000C\)$`\1,\2 ; to branch_destination_0x6585`
else
  echoerr 'Branch not found'
  wq
endif


" Branch word at 0x6581 in U< 
if search('defw branch_cfa\s;\s0x6581\n\s\+defw 0x0006$','wc')
  silent s`\(defw branch_cfa\)\s;\s0x[A-F0-9]\{4}\n\s\+defw \(0x0006\)$`\1,\2 ; to branch_destination_0x6589`
else
  echoerr 'Branch not found'
  wq
endif
