# word_labels.sed

# This sed program translates the temporary Z80 labels
# used in the file created by dis.

# 2015-05-24: Start.

s` C_\([nlpc]\)fa\>` c_\1fa`g
s` TILL_\([nlpc]\)fa\>` till_\1fa`g
s` X_\([nlpc]\)fa\>` x_\1fa`g
s` B_\([nlpc]\)fa\>` b_\1fa`g
s` F_\([nlpc]\)fa\>` f_\1fa`g
s` N_\([nlpc]\)fa\>` n_\1fa`g
s` DELETE_\([nlpc]\)fa\>` delete_\1fa`g
s` FIND_\([nlpc]\)fa\>` find_\1fa`g
s` 1LINE_\([nlpc]\)fa\>` oneline_\1fa`g
s` MATCH_\([nlpc]\)fa\>` match_\1fa`g
s` -TEXT_\([nlpc]\)fa\>` minus_text_\1fa`g
s` COPY_\([nlpc]\)fa\>` copy_\1fa`g
s` CLEAR_\([nlpc]\)fa\>` clear_\1fa`g
s` TOP_\([nlpc]\)fa\>` top_\1fa`g
s` editor_I_\([nlpc]\)fa\>` editor_i_\1fa`g
s` P_\([nlpc]\)fa\>` p_\1fa`g
s` editor_R_\([nlpc]\)fa\>` editor_r_\1fa`g
s` L_\([nlpc]\)fa\>` l_\1fa`g
s` T_\([nlpc]\)fa\>` t_\1fa`g
s` M_\([nlpc]\)fa\>` m_\1fa`g
s` D_\([nlpc]\)fa\>` d_\1fa`g
s` S_\([nlpc]\)fa\>` s_\1fa`g
s` E_\([nlpc]\)fa\>` e_\1fa`g
s` H_\([nlpc]\)fa\>` h_\1fa`g
s` -MOVE_\([nlpc]\)fa\>` minus_move_\1fa`g
s` #LAG_\([nlpc]\)fa\>` hash_lag_\1fa`g
s` #LEAD_\([nlpc]\)fa\>` hash_lead_\1fa`g
s` #LOCATE_\([nlpc]\)fa\>` hash_locate_\1fa`g
s` UDG_\([nlpc]\)fa\>` udg_\1fa`g
s` INIT-DISC_\([nlpc]\)fa\>` init_disc_\1fa`g
s` INKEY_\([nlpc]\)fa\>` inkey_\1fa`g
s` ENDCASE_\([nlpc]\)fa\>` endcase_\1fa`g
s` ENDOF_\([nlpc]\)fa\>` endof_\1fa`g
s` OF_\([nlpc]\)fa\>` of_\1fa`g
s` CASE_\([nlpc]\)fa\>` case_\1fa`g
s` DRAW_\([nlpc]\)fa\>` draw_\1fa`g
s` INCY_\([nlpc]\)fa\>` incy_\1fa`g
s` INCX_\([nlpc]\)fa\>` incx_\1fa`g
s` Y1_\([nlpc]\)fa\>` y1_\1fa`g
s` X1_\([nlpc]\)fa\>` x1_\1fa`g
s` PLOT_\([nlpc]\)fa\>` plot_\1fa`g
s` EXIT_\([nlpc]\)fa\>` exit_\1fa`g
s` 2OVER_\([nlpc]\)fa\>` two_over_\1fa`g
s` U\.R_\([nlpc]\)fa\>` u_dot_r_\1fa`g
s` 2VARIABLE_\([nlpc]\)fa\>` two_variable_\1fa`g
s` 2CONSTANT_\([nlpc]\)fa\>` two_constant_\1fa`g
s` J_\([nlpc]\)fa\>` j_\1fa`g
s` I'_\([nlpc]\)fa\>` i_tick_\1fa`g
s` NOT_\([nlpc]\)fa\>` not_\1fa`g
s` INVERSE_\([nlpc]\)fa\>` inverse_\1fa`g
s` GOVER_\([nlpc]\)fa\>` gover_\1fa`g
s` BRIGHT_\([nlpc]\)fa\>` bright_\1fa`g
s` FLASH_\([nlpc]\)fa\>` flash_\1fa`g
s` INK_\([nlpc]\)fa\>` ink_\1fa`g
s` POINT_\([nlpc]\)fa\>` point_\1fa`g
s` ATTR_\([nlpc]\)fa\>` attr_\1fa`g
s` PAPER_\([nlpc]\)fa\>` paper_\1fa`g
s` BLEEP_\([nlpc]\)fa\>` bleep_\1fa`g
s` BORDER_\([nlpc]\)fa\>` border_\1fa`g
s` AT_\([nlpc]\)fa\>` at_\1fa`g
s` SCREEN_\([nlpc]\)fa\>` screen_\1fa`g
s` OUTP_\([nlpc]\)fa\>` outp_\1fa`g
s` INP_\([nlpc]\)fa\>` inp_\1fa`g
s` PUSHDE_\([nlpc]\)fa\>` pushde_\1fa`g
s` PUSHHL_\([nlpc]\)fa\>` pushhl_\1fa`g
s` NEXT_\([nlpc]\)fa\>` next_\1fa`g
s` WHERE_\([nlpc]\)fa\>` where_\1fa`g
s` EDITOR_\([nlpc]\)fa\>` editor_\1fa`g
s` TRIAD_\([nlpc]\)fa\>` triad_\1fa`g
s` INDEX_\([nlpc]\)fa\>` index_\1fa`g
s` FORGET_\([nlpc]\)fa\>` forget_\1fa`g
s` FREE_\([nlpc]\)fa\>` free_\1fa`g
s` SIZE_\([nlpc]\)fa\>` size_\1fa`g
s` 2SWAP_\([nlpc]\)fa\>` two_swap_\1fa`g
s` 2DROP_\([nlpc]\)fa\>` two_drop_\1fa`g
s` VERIFY_\([nlpc]\)fa\>` verify_\1fa`g
s` SAVET_\([nlpc]\)fa\>` savet_\1fa`g
s` LOADT_\([nlpc]\)fa\>` loadt_\1fa`g
s` LINE_\([nlpc]\)fa\>` line_\1fa`g
s` TEXT_\([nlpc]\)fa\>` text_\1fa`g
s` MON_\([nlpc]\)fa\>` mon_\1fa`g
s` (TAPE)_\([nlpc]\)fa\>` paren_tape_\1fa`g
s` \.CPU_\([nlpc]\)fa\>` dot_cpu_\1fa`g
s` CLS_\([nlpc]\)fa\>` cls_\1fa`g
s` LINK_\([nlpc]\)fa\>` link_\1fa`g
s` LIST_\([nlpc]\)fa\>` list_\1fa`g
s` VLIST_\([nlpc]\)fa\>` vlist_\1fa`g
s` U\._\([nlpc]\)fa\>` u_dot_\1fa`g
s` ?_\([nlpc]\)fa\>` question_\1fa`g
s` \._\([nlpc]\)fa\>` dot_\1fa`g
s` D\._\([nlpc]\)fa\>` d_dot_\1fa`g
s` \.R_\([nlpc]\)fa\>` dot_r_\1fa`g
s` D\.R_\([nlpc]\)fa\>` d_dot_r_\1fa`g
s` #S_\([nlpc]\)fa\>` hash_s_\1fa`g
s` #_\([nlpc]\)fa\>` hash_\1fa`g
s` SIGN_\([nlpc]\)fa\>` sign_\1fa`g
s` #>_\([nlpc]\)fa\>` hash_greater_\1fa`g
s` <#_\([nlpc]\)fa\>` less_hash_\1fa`g
s` SPACES_\([nlpc]\)fa\>` spaces_\1fa`g
s` WHILE_\([nlpc]\)fa\>` while_\1fa`g
s` ELSE_\([nlpc]\)fa\>` else_\1fa`g
s` IF_\([nlpc]\)fa\>` if_\1fa`g
s` REPEAT_\([nlpc]\)fa\>` repeat_\1fa`g
s` AGAIN_\([nlpc]\)fa\>` again_\1fa`g
s` END_\([nlpc]\)fa\>` end_\1fa`g
s` UNTIL_\([nlpc]\)fa\>` until_\1fa`g
s` +LOOP_\([nlpc]\)fa\>` plus_loop_\1fa`g
s` LOOP_\([nlpc]\)fa\>` loop_\1fa`g
s` DO_\([nlpc]\)fa\>` do_\1fa`g
s` THEN_\([nlpc]\)fa\>` then_\1fa`g
s` ENDIF_\([nlpc]\)fa\>` endif_\1fa`g
s` BEGIN_\([nlpc]\)fa\>` begin_\1fa`g
s` BACK_\([nlpc]\)fa\>` back_\1fa`g
s` '_\([nlpc]\)fa\>` tick_\1fa`g
s` -->_\([nlpc]\)fa\>` next_screen_\1fa`g
s` LOAD_\([nlpc]\)fa\>` load_\1fa`g
s` FLUSH_\([nlpc]\)fa\>` flush_\1fa`g
s` R/W_\([nlpc]\)fa\>` read_write_\1fa`g
s` HI_\([nlpc]\)fa\>` hi_\1fa`g
s` LO_\([nlpc]\)fa\>` lo_\1fa`g
s` BLOCK_\([nlpc]\)fa\>` block_\1fa`g
s` BUFFER_\([nlpc]\)fa\>` buffer_\1fa`g
s` DR0_\([nlpc]\)fa\>` dr0_\1fa`g
s` EMPTY-BUFFERS_\([nlpc]\)fa\>` empty_buffers_\1fa`g
s` UPDATE_\([nlpc]\)fa\>` update_\1fa`g
s` +BUF_\([nlpc]\)fa\>` plus_buf_\1fa`g
s` #BUFF_\([nlpc]\)fa\>` hash_buff_\1fa`g
s` PREV_\([nlpc]\)fa\>` prev_\1fa`g
s` USE_\([nlpc]\)fa\>` use_\1fa`g
s` MESSAGE_\([nlpc]\)fa\>` message_\1fa`g
s` \.LINE_\([nlpc]\)fa\>` dot_line_\1fa`g
s` (LINE)_\([nlpc]\)fa\>` paren_line_\1fa`g
s` M/MOD_\([nlpc]\)fa\>` m_slash_mod_\1fa`g
s` \*/_\([nlpc]\)fa\>` star_slash_\1fa`g
s` \*/MOD_\([nlpc]\)fa\>` star_slash_mod_\1fa`g
s` MOD_\([nlpc]\)fa\>` mod_\1fa`g
s` /_\([nlpc]\)fa\>` slash_\1fa`g
s` /MOD_\([nlpc]\)fa\>` slash_mod_\1fa`g
s` \*_\([nlpc]\)fa\>` star_\1fa`g
s` M/_\([nlpc]\)fa\>` m_slash_\1fa`g
s` M\*_\([nlpc]\)fa\>` m_star_\1fa`g
s` MAX_\([nlpc]\)fa\>` max_\1fa`g
s` MIN_\([nlpc]\)fa\>` min_\1fa`g
s` DABS_\([nlpc]\)fa\>` dabs_\1fa`g
s` ABS_\([nlpc]\)fa\>` abs_\1fa`g
s` D+-_\([nlpc]\)fa\>` d_plus_minus_\1fa`g
s` +-_\([nlpc]\)fa\>` plus_minus_\1fa`g
s` S->D_\([nlpc]\)fa\>` s_to_d_\1fa`g
s` COLD_\([nlpc]\)fa\>` cold_\1fa`g
s` WARM_\([nlpc]\)fa\>` warm_\1fa`g
s` ABORT_\([nlpc]\)fa\>` abort_\1fa`g
s` QUIT_\([nlpc]\)fa\>` quit_\1fa`g
s` (_\([nlpc]\)fa\>` paren_\1fa`g
s` DEFINITIONS_\([nlpc]\)fa\>` definitions_\1fa`g
s` FORTH_\([nlpc]\)fa\>` forth_\1fa`g
s` VOCABULARY_\([nlpc]\)fa\>` vocabulary_\1fa`g
s` IMMEDIATE_\([nlpc]\)fa\>` immediate_\1fa`g
s` INTERPRET_\([nlpc]\)fa\>` interpret_\1fa`g
s` ?STACK_\([nlpc]\)fa\>` question_stack_\1fa`g
s` DLITERAL_\([nlpc]\)fa\>` dliteral_\1fa`g
s` LITERAL_\([nlpc]\)fa\>` literal_\1fa`g
s` \[COMPILE]_\([nlpc]\)fa\>` bracket_compile_\1fa`g
s` CREATE_\([nlpc]\)fa\>` create_\1fa`g
s` ID\._\([nlpc]\)fa\>` id_dot_\1fa`g
s` ERROR_\([nlpc]\)fa\>` error_\1fa`g
s` (ABORT)_\([nlpc]\)fa\>` paren_abort_\1fa`g
s` -FIND_\([nlpc]\)fa\>` minus_find_\1fa`g
s` NUMBER_\([nlpc]\)fa\>` number_\1fa`g
s` (NUMBER)_\([nlpc]\)fa\>` paren_number_\1fa`g
s` WORD_\([nlpc]\)fa\>` word_\1fa`g
s` PAD_\([nlpc]\)fa\>` pad_\1fa`g
s` HOLD_\([nlpc]\)fa\>` hold_\1fa`g
s` BLANKS_\([nlpc]\)fa\>` blanks_\1fa`g
s` ERASE_\([nlpc]\)fa\>` erase_\1fa`g
s` FILL_\([nlpc]\)fa\>` fill_\1fa`g
s` QUERY_\([nlpc]\)fa\>` query_\1fa`g
s` EXPECT_\([nlpc]\)fa\>` expect_\1fa`g
s` \."_\([nlpc]\)fa\>` dot_quote_\1fa`g
s` (\.")_\([nlpc]\)fa\>` paren_dot_quote_\1fa`g
s` -TRAILING_\([nlpc]\)fa\>` minus_trailing_\1fa`g
s` TYPE_\([nlpc]\)fa\>` type_\1fa`g
s` COUNT_\([nlpc]\)fa\>` count_\1fa`g
s` DOES>_\([nlpc]\)fa\>` does_\1fa`g
s` <BUILDS_\([nlpc]\)fa\>` builds_\1fa`g
s` ;CODE_\([nlpc]\)fa\>` semicolon_code_\1fa`g
s` (;CODE)_\([nlpc]\)fa\>` paren_semicolon_code_\1fa`g
s` DECIMAL_\([nlpc]\)fa\>` decimal_\1fa`g
s` HEX_\([nlpc]\)fa\>` hex_\1fa`g
s` SMUDGE_\([nlpc]\)fa\>` smudge_\1fa`g
s` ]_\([nlpc]\)fa\>` right_bracket_\1fa`g
s` \[_\([nlpc]\)fa\>` left_bracket_\1fa`g
s` COMPILE_\([nlpc]\)fa\>` compile_\1fa`g
s` ?LOADING_\([nlpc]\)fa\>` question_loading_\1fa`g
s` ?CSP_\([nlpc]\)fa\>` question_csp_\1fa`g
s` ?PAIRS_\([nlpc]\)fa\>` question_pairs_\1fa`g
s` ?EXEC_\([nlpc]\)fa\>` question_exec_\1fa`g
s` ?COMP_\([nlpc]\)fa\>` question_comp_\1fa`g
s` ?ERROR_\([nlpc]\)fa\>` question_error_\1fa`g
s` !CSP_\([nlpc]\)fa\>` store_csp_\1fa`g
s` PFA_\([nlpc]\)fa\>` pfa_\1fa`g
s` NFA_\([nlpc]\)fa\>` nfa_\1fa`g
s` CFA_\([nlpc]\)fa\>` cfa_\1fa`g
s` LFA_\([nlpc]\)fa\>` lfa_\1fa`g
s` LATEST_\([nlpc]\)fa\>` latest_\1fa`g
s` TRAVERSE_\([nlpc]\)fa\>` traverse_\1fa`g
s` -DUP_\([nlpc]\)fa\>` minus_dup_\1fa`g
s` SPACE_\([nlpc]\)fa\>` space_\1fa`g
s` ROT_\([nlpc]\)fa\>` rot_\1fa`g
s` >_\([nlpc]\)fa\>` greater_than_\1fa`g
s` U<_\([nlpc]\)fa\>` u_less_than_\1fa`g
s` <_\([nlpc]\)fa\>` less_than_\1fa`g
s` =_\([nlpc]\)fa\>` equals_\1fa`g
s` -_\([nlpc]\)fa\>` minus_\1fa`g
s` C,_\([nlpc]\)fa\>` c_comma_\1fa`g
s` ,_\([nlpc]\)fa\>` comma_\1fa`g
s` ALLOT_\([nlpc]\)fa\>` allot_\1fa`g
s` HERE_\([nlpc]\)fa\>` here_\1fa`g
s` 2+_\([nlpc]\)fa\>` two_plus_\1fa`g
s` 1+_\([nlpc]\)fa\>` one_plus_\1fa`g
s` HLD_\([nlpc]\)fa\>` hld_\1fa`g
s` R#_\([nlpc]\)fa\>` r_hash_\1fa`g
s` CSP_\([nlpc]\)fa\>` csp_\1fa`g
s` FLD_\([nlpc]\)fa\>` fld_\1fa`g
s` DPL_\([nlpc]\)fa\>` dpl_\1fa`g
s` BASE_\([nlpc]\)fa\>` base_\1fa`g
s` STATE_\([nlpc]\)fa\>` state_\1fa`g
s` CURRENT_\([nlpc]\)fa\>` current_\1fa`g
s` CONTEXT_\([nlpc]\)fa\>` context_\1fa`g
s` OFFSET_\([nlpc]\)fa\>` offset_\1fa`g
s` SCR_\([nlpc]\)fa\>` scr_\1fa`g
s` OUT_\([nlpc]\)fa\>` out_\1fa`g
s` IN_\([nlpc]\)fa\>` in_\1fa`g
s` BLK_\([nlpc]\)fa\>` blk_\1fa`g
s` VOC-LINK_\([nlpc]\)fa\>` voc_link_\1fa`g
s` DP_\([nlpc]\)fa\>` dp_\1fa`g
s` FENCE_\([nlpc]\)fa\>` fence_\1fa`g
s` WARNING_\([nlpc]\)fa\>` warning_\1fa`g
s` WIDTH_\([nlpc]\)fa\>` width_\1fa`g
s` TIB_\([nlpc]\)fa\>` tib_\1fa`g
s` R0_\([nlpc]\)fa\>` r0_\1fa`g
s` S0_\([nlpc]\)fa\>` s0_\1fa`g
s` +ORIGIN_\([nlpc]\)fa\>` plus_origin_\1fa`g
s` B/SCR_\([nlpc]\)fa\>` b_slash_scr_\1fa`g
s` B/BUF_\([nlpc]\)fa\>` b_slash_buf_\1fa`g
s` LIMIT_\([nlpc]\)fa\>` limit_\1fa`g
s` FIRST_\([nlpc]\)fa\>` first_\1fa`g
s` C/L_\([nlpc]\)fa\>` c_slash_l_\1fa`g
s` BL_\([nlpc]\)fa\>` b_l_\1fa`g
s` 3_\([nlpc]\)fa\>` three_\1fa`g
s` 2_\([nlpc]\)fa\>` two_\1fa`g
s` 1_\([nlpc]\)fa\>` one_\1fa`g
s` 0_\([nlpc]\)fa\>` zero_\1fa`g
s` USER_\([nlpc]\)fa\>` user_\1fa`g
s` VARIABLE_\([nlpc]\)fa\>` variable_\1fa`g
s` CONSTANT_\([nlpc]\)fa\>` constant_\1fa`g
s` NOOP_\([nlpc]\)fa\>` noop_\1fa`g
s` ;_\([nlpc]\)fa\>` semicolon_\1fa`g
s` :_\([nlpc]\)fa\>` colon_\1fa`g
s` 2!_\([nlpc]\)fa\>` two_store_\1fa`g
s` C!_\([nlpc]\)fa\>` c_store_\1fa`g
s` !_\([nlpc]\)fa\>` store_\1fa`g
s` 2@_\([nlpc]\)fa\>` two_fetch_\1fa`g
s` C@_\([nlpc]\)fa\>` c_fetch_\1fa`g
s` @_\([nlpc]\)fa\>` fetch_\1fa`g
s` TOGGLE_\([nlpc]\)fa\>` toggle_\1fa`g
s` +!_\([nlpc]\)fa\>` plus_store_\1fa`g
s` 2DUP_\([nlpc]\)fa\>` two_dup_\1fa`g
s` DUP_\([nlpc]\)fa\>` dup_\1fa`g
s` SWAP_\([nlpc]\)fa\>` swap_\1fa`g
s` DROP_\([nlpc]\)fa\>` drop_\1fa`g
s` OVER_\([nlpc]\)fa\>` over_\1fa`g
s` DMINUS_\([nlpc]\)fa\>` dminus_\1fa`g
s` MINUS_\([nlpc]\)fa\>` minus_\1fa`g
s` D+_\([nlpc]\)fa\>` d_plus_\1fa`g
s` +_\([nlpc]\)fa\>` plus_\1fa`g
s` 0<_\([nlpc]\)fa\>` zero_less_than_\1fa`g
s` 0=_\([nlpc]\)fa\>` zero_equals_\1fa`g
s` R_\([nlpc]\)fa\>` r_\1fa`g
s` R>_\([nlpc]\)fa\>` from_r_\1fa`g
s` >R_\([nlpc]\)fa\>` to_r_\1fa`g
s` LEAVE_\([nlpc]\)fa\>` leave_\1fa`g
s` ;S_\([nlpc]\)fa\>` semicolon_s_\1fa`g
s` RP!_\([nlpc]\)fa\>` rp_store_\1fa`g
s` RP@_\([nlpc]\)fa\>` rp_fetch_\1fa`g
s` SP!_\([nlpc]\)fa\>` sp_store_\1fa`g
s` SP@_\([nlpc]\)fa\>` sp_fetch_\1fa`g
s` XOR_\([nlpc]\)fa\>` xor_\1fa`g
s` OR_\([nlpc]\)fa\>` or_\1fa`g
s` AND_\([nlpc]\)fa\>` and_\1fa`g
s` U/MOD_\([nlpc]\)fa\>` u_slash_mod_\1fa`g
s` U\*_\([nlpc]\)fa\>` u_star_\1fa`g
s` CMOVE_\([nlpc]\)fa\>` cmove_\1fa`g
s` CR_\([nlpc]\)fa\>` cr_\1fa`g
s` ?TERMINAL_\([nlpc]\)fa\>` question_terminal_\1fa`g
s` KEY_\([nlpc]\)fa\>` key_\1fa`g
s` EMIT_\([nlpc]\)fa\>` emit_\1fa`g
s` ENCLOSE_\([nlpc]\)fa\>` enclose_\1fa`g
s` (FIND)_\([nlpc]\)fa\>` paren_find_\1fa`g
s` DIGIT_\([nlpc]\)fa\>` digit_\1fa`g
s` I_\([nlpc]\)fa\>` i_\1fa`g
s` (DO)_\([nlpc]\)fa\>` paren_do_\1fa`g
s` (+LOOP)_\([nlpc]\)fa\>` paren_plus_loop_\1fa`g
s` (LOOP)_\([nlpc]\)fa\>` paren_loop_\1fa`g
s` 0BRANCH_\([nlpc]\)fa\>` zero_branch_\1fa`g
s` BRANCH_\([nlpc]\)fa\>` branch_\1fa`g
s` EXECUTE_\([nlpc]\)fa\>` execute_\1fa`g
s` LIT_\([nlpc]\)fa\>` lit_\1fa`g