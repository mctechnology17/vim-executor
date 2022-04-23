"=========================================
" FileName: sh.vim
" Date: 19:06 18.April.2022
" Author: Marcos Chow Castro
" Email: mctechnology170318@gmail.com
" GitHub: https://github.com/mctechnology17
" Brief: <brief>
"==========================================
""" all local vars {{{
let s:is_win=expand(has('win32')||has('win64')||has("win16")||has("win95"))
let s:is_vim = !has('nvim')
let s:is_nvim = has('nvim')
let s:is_mac = has('mac')||has('macunix')
let s:is_linux = has('unix')&&!(has('mac')||has('macunix'))
let s:plugin_path = expand('<sfile>:p:h:h')
let s:base_dir = expand('<sfile>:h:h')
"}}}
""" executor#sh#run {{{
function! executor#sh#run()
  if g:executor_input_args == 1
    let g:executor_program_args_sh = executor#Args()
  elseif g:executor_input_args == 0
    let g:executor_program_args_sh = ''
  endif

  if s:is_nvim
    exe 'vsplit term://sh '.g:executor_compiler_flags_sh.' % '.g:executor_program_args_sh
  else
    exe 'vert term sh '.g:executor_compiler_flags_sh.' % '.g:executor_program_args_sh
  endif
endfunction
"}}}

" vim: set fdm=marker:
