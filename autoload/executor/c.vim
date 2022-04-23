"=========================================
" FileName: c.vim
" Date: 00:18 17.April.2022
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
""" executor#c#compiler {{{
function executor#c#compiler()
  if g:executor_compiler_run_code
    if s:is_mac
      if s:is_nvim
         exe 'vsplit term://clang % '.g:executor_compiler_flags_c.' -o %<.x && ./%<.x '.g:executor_program_args_c
      else
        exe 'vert term ++shell clang %:p '.g:executor_compiler_flags_c.' -o %:p:r.x && %:p:r.x '.g:executor_program_args_c
      endif
    elseif s:is_linux
       if s:is_nvim
        exe 'vsplit term://gcc % '.g:executor_compiler_flags_c.' -o %<.x && ./%<.x '.g:executor_program_args_c
      else
        exe 'vert term ++shell gcc %:p '.g:executor_compiler_flags_c.' -o %:p:r.x && %:p:r.x '.g:executor_program_args_c
      endif
    endif
  else
    if s:is_mac
      if s:is_nvim
         exe 'vsplit term://clang % '.g:executor_compiler_flags_c.' -o %<.x'
      else
        exe 'vert term ++shell clang %:p '.g:executor_compiler_flags_c.' -o %:p:r.x'
      endif
    elseif s:is_linux
       if s:is_nvim
        exe 'vsplit term://gcc % '.g:executor_compiler_flags_c.' -o %<.x'
      else
        exe 'vert term ++shell gcc %:p '.g:executor_compiler_flags_c.' -o %:p:r.x'
      endif
    endif
  endif
endfunction
"}}}
""" executor#c#run {{{
function executor#c#run()
  if g:executor_input_args == 1
    let g:executor_program_args_c = executor#Args()
  elseif g:executor_input_args == 0
    let g:executor_program_args_c = ''
  endif

  " This addresses the issue of having a file that does exist, but permissions
  " prevent it from being read.
  if !empty(expand(glob("%<.x")))
    if s:is_nvim
      exe 'vsplit term://./%<.x '.g:executor_program_args_c
    else
      exe 'vert term ./%<.x '.g:executor_program_args_c
    endif
  else
    if s:is_mac
      if s:is_nvim
         exe 'vsplit term://clang % '.g:executor_compiler_flags_c.' -o %<.x && ./%<.x '.g:executor_program_args_c
      else
        exe 'vert term ++shell clang %:p '.g:executor_compiler_flags_c.' -o %:p:r.x && %:p:r.x '.g:executor_program_args_c
      endif
    elseif s:is_linux
       if s:is_nvim
        exe 'vsplit term://gcc % '.g:executor_compiler_flags_c.' -o %<.x && ./%<.x '.g:executor_program_args_c
      else
        exe 'vert term ++shell gcc %:p '.g:executor_compiler_flags_c.' -o %:p:r.x && %:p:r.x '.g:executor_program_args_c
      endif
    endif
  endif
endfunction
"}}}

" vim: set fdm=marker:
