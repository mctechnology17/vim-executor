"=========================================
" FileName: latex.vim
" Date: 12:04 17.April.2022
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
""" executor#latex#run {{{
function executor#latex#run()
    if exists(':LLPStartPreview')
      exe "LLPStartPreview"
    else
      echohl WarningMsg
      echomsg "The plugin is not installed please install it first and try again"
      echomsg "you have to put this in your vimrc: "
      echomsg "Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }"
      echomsg "go to the developer's GitHub and follow the instructions"
      echohl None
    endif
endfunction
"}}}
""" executor#latex#compiler {{{
" TODO: pandoc --verbose % -o %<.pdf && open %<.pdf
function executor#latex#compiler()
  if g:executor_compiler_run_code
    if s:is_mac
      let s:open = '&& open %<.pdf'
    elseif s:is_linux
      let s:open = '&& xdg-open %<.pdf'
    endif
  else
      let s:open =
            \ get(s:, 'open', '')
  endif

  if s:is_mac
    if s:is_nvim
      exe 'vsplit term://pdflatex '.g:executor_compiler_flags_latex.' % '.s:open
    else
      exe 'vert term pdflatex '.g:executor_compiler_flags_latex.' % '.s:open
    endif
  elseif s:is_linux
    if s:is_nvim
      exe 'vsplit term://pdflatex '.g:executor_compiler_flags_latex.' % '.s:open
    else
      exe 'vert term pdflatex '.g:executor_compiler_flags_latex.' % '.s:open
    endif
  endif
endfunction
"}}}

" vim: set fdm=marker:
