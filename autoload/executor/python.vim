"=========================================
" FileName: python.vim
" Date: 00:21 17.April.2022
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
""" executor#python#run {{{
function! executor#python#run()
  if g:executor_input_args == 1
    let g:executor_program_args_python = executor#Args()
  elseif g:executor_input_args == 0
    let g:executor_program_args_python = ''
  endif

  if s:is_nvim
    exe 'vsplit term://python '.g:executor_compiler_flags_python.' % '.g:executor_program_args_python
  else
    exe 'vert term python '.g:executor_compiler_flags_python.' % '.g:executor_program_args_python
  endif
endfunction
"}}}
""" s:ExecutorDebuggerPythonPDBPP {{{
function executor#python#debuggerpdbpp()
  if g:executor_input_args == 1
    let g:executor_program_args_python = executor#Args()
  elseif g:executor_input_args == 0
    let g:executor_program_args_python = ''
  endif

  if has('python3')
    if s:is_nvim
      " exe 'vsplit term://python '.g:executor_compiler_flags_python.' % '.g:executor_program_args_python
      exe 'vsplit term://python '
            \ .g:executor_compiler_flags_python.' '.g:executor_debugger_flags_python.
            \ ' pdb % '.g:executor_program_args_python
    else
      " execute 'vert term python '.g:executor_pdbpp_flags.' pdb % '.g:executor_program_args
      exe 'vert term python '
            \ .g:executor_compiler_flags_python.' '.g:executor_debugger_flags_python.
            \ ' pdb % '.g:executor_program_args_python
    endif
  else
    echohl Error
    echom 'executor: python3 not found'
    echohl None
  endif
endfunction
"}}}

" vim: set fdm=marker:
