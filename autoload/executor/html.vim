"=========================================
" FileName: html.vim
" Date: 12:04 17.April.2022
" Author: Marcos Chow Castro
" Email: mctechnology170318@gmail.com
" GitHub: https://github.com/mctechnology17
" Brief: <brief>
"==========================================
""" executor#html#run {{{
function executor#html#run()
    if exists(':Bracey')
      exe "Bracey"
    else
      echohl WarningMsg
      echomsg "The plugin is not installed please install it first and try again"
      echomsg "you have to put this in your vimrc: "
      echomsg "Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}"
      echomsg "go to the developer's GitHub and follow the instructions"
      echohl None
    endif
endfunction
"}}}

" vim: set fdm=marker:
