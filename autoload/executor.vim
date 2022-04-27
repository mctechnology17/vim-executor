"=========================================
" FileName: executor.vim
" Date: 21:48 11.April.2022
" Author: Marcos Chow Castro
" Email: mctechnology170318@gmail.com
" GitHub: https://github.com/mctechnology17
" Brief: <brief>
"==========================================
scriptencoding utf-8
" TODO: comprobar todos los interpretes para Compiler, CleanUp y RunFile
" executable('Rscript') ejemplo de como identificar un interprete
" 2. crear archivo de configuracion local estilo .zshrc .executor.vim
""" all local vars {{{
let s:is_win=expand(has('win32')||has('win64')||has("win16")||has("win95"))
" if s:is_win && !has('win32unix')
  " echohl Error
  " echom 'executor: Windows system no supported for this feature'
  " echohl None
  " finish
" endif
let s:is_vim = !has('nvim')
let s:is_nvim = has('nvim')
let s:is_mac = has('mac')||has('macunix')
let s:is_linux = has('unix')&&!(has('mac')||has('macunix'))
let s:plugin_path = expand('<sfile>:p:h:h')
let s:base_dir = expand('<sfile>:h:h')
"}}}
""" executor#GlobalVariable {{{
function! executor#GlobalVariable()
  """ g:executor_esc {{{
  if g:executor_esc == 1
    au BufEnter * if &buftype == 'terminal'
          \ | tnoremap <Esc> <C-\><C-n>
          \ | endif
  elseif g:executor_esc == 2
    au BufEnter * if &buftype == 'terminal'
          \ | tnoremap <Esc><Esc> <C-\><C-n>
          \ | endif
  endif
  "}}}
  """ g:executor_jump {{{
  if g:executor_jump == 1
    noremap <S-LEFT> <C-w>h
    noremap <S-DOWN> <C-w>j
    noremap <S-UP> <C-w>k
    noremap <S-RIGHT> <C-w>l
    tnoremap <S-LEFT> <C-\><C-N><C-w>h
    tnoremap <S-DOWN> <C-\><C-N><C-w>j
    tnoremap <S-UP> <C-\><C-N><C-w>k
    tnoremap <S-RIGHT> <C-\><C-N><C-w>l
  elseif g:executor_jump == 2
    noremap <Leader><LEFT> <C-w>h
    noremap <Leader><DOWN> <C-w>j
    noremap <Leader><UP> <C-w>k
    noremap <Leader><RIGHT> <C-w>l
    tnoremap <Leader><LEFT> <C-\><C-N><C-w>h
    tnoremap <Leader><DOWN> <C-\><C-N><C-w>j
    tnoremap <Leader><UP> <C-\><C-N><C-w>k
    tnoremap <Leader><RIGHT> <C-\><C-N><C-w>l
  elseif g:executor_jump == 3
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l
  endif
  "}}}
  " TODO: toggle for g:executor_file_mapping linke windows resize
  """ g:executor_file_mapping {{{
  if g:executor_file_mapping == 1
    noremap cd :lcd %:p:h \| :echohl MoreMsg \| echom ' executor: Change directory to '.expand('%') \| echohl None<CR>
    " noremap fi :!find . -iname '*%<*' -type f<CR>
    noremap fi :call executor#FindFileName()<CR>
    noremap fl :ls<CR>:e #
    noremap fs :!grep -in --color <C-R>=expand("<cword>")<CR> *.*<CR>
    noremap fm :tab sp \| :echohl MoreMsg \| echom ' executor: FileMaximized ' \| echohl None<CR>
    noremap fw :e <C-R>=expand("%:p:h") . "/" <CR>
    noremap fo :tabe <C-R>=expand("%:p:h") . "/" <CR>
    noremap fr :call executor#ChangeBufferName()<CR>
  endif
  "}}}
endfunction
""" executor#ChangeBufferName {{{
function! executor#ChangeBufferName()
  call inputsave()
  let s:buffer = input('Write buffer name: ')
  call inputrestore()
  if s:buffer == ''
    return
  endif
  exe 'f '.s:buffer
endfunction
"}}}
""" executor#FindFileName {{{
" TODO : expand function file name for tex and plaintex
function! executor#FindFileName()
  call inputsave()
  let s:find_filename = input('Write file name to find/only ENTER matches current file name: ')
  call inputrestore()
  if s:find_filename == '' && (&filetype == 'c'||&filetype == 'cpp')
    let s:find_filename = '%:t:r.[ox]'
    if s:is_nvim
      exe 'vsplit term://find . -iname '.s:find_filename.' -type f'
    else
      exe 'vert term ++shell find . -iname '.s:find_filename.' -type f'
    endif
  elseif s:find_filename == '' && (&filetype == 'tex'|| &filetype == 'plaintex')
    " test.aux test.bcf test.log test.ltx test.pdf
    " let s:clean = get(s:, 'clean', '%<.pdf %<.log %<.aux')
    let s:find_filename = '%:t:r.pdf'
    if s:is_nvim
      exe 'vsplit term://find . -iname '.s:find_filename.' -type f'
    else
      exe 'vert term ++shell find . -iname '.s:find_filename.' -type f'
    endif
  elseif s:find_filename == ''
    let s:find_filename = '%:t'
    if s:is_nvim
      exe 'vsplit term://find . -iname '.s:find_filename.' -type f'
    else
      exe 'vert term ++shell find . -iname '.s:find_filename.' -type f'
    endif
  else
    if s:is_nvim
      exe 'vsplit term://find . -iname '.s:find_filename.' -type f'
    else
      exe 'vert term ++shell find . -iname '.s:find_filename.' -type f'
    endif
  endif
endfunction
"}}}
""" g:executor_program_args {{{
function! executor#Args()
  call inputsave()
  let s:args = input('Enter arguments: ')
  let g:executor_program_args = s:args
  call inputrestore()
  return resolve(expand(g:executor_program_args))
endfunction

function! executor#ToggleArgs()
  if g:executor_input_args == 1
    let g:executor_input_args = 0
    echohl MoreMsg | echom ' executor: Args OFF ' | echohl None
  elseif g:executor_input_args == 0
    let g:executor_input_args = 1
    echohl MoreMsg | echom ' executor: Args ON ' | echohl None
  endif
endfunction
"}}}
"}}}
""" s:is_shell {{{
function! s:DefineShell()
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  let is_shell = &shell
  if s:is_nvim
    if is_shell == 'zsh'
      return resolve('zsh')
    elseif is_shell == 'fish'
      return resolve('fish')
    else
      return resolve('bash')
    endif
  endif
  if s:is_vim
    return resolve('terminal')
  endif
endfunction
let s:is_shell = s:DefineShell()
"}}}
" TODO: agregar la parte de los debugger a cada lenguaje de programacion
" por ejemplo la instalacion de pdbpp a python
""" executor#InstallPDBPP {{{
function! executor#InstallPDBPP()
  let script = s:base_dir.'/install.sh'
  if !executable(script)
    throw script.' not found'
  endif
  unlet script

  if s:is_nvim
    exe 'vsplit term://'.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp'
  else
    exe 'vert '.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp'
  endif
endfunction
"}}}
""" executor#UninstallPDBPP {{{
function! executor#UninstallPDBPP()
  let script = s:base_dir.'/install.sh'
  if !executable(script)
    throw script.' not found'
  endif
  unlet script

  if s:is_nvim
    exe 'vsplit term://'.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp_uninstall'
  else
    exe 'vert '.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp_uninstall'
  endif
endfunction
"}}}
""" executor#InstallPDBPPConda {{{
function! executor#InstallPDBPPConda()
  let script = s:base_dir.'/install.sh'
  if !executable(script)
    throw script.' not found'
  endif
  unlet script

  if s:is_nvim
    exe 'vsplit term://'.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp_conda'
  else
    exe 'vert '.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp_conda'
  endif
endfunction
"}}}
""" executor#InstallPDBPPCondaUninstall {{{
function! executor#UninstallPDBPPConda()
  let script = s:base_dir.'/install.sh'
  if !executable(script)
    throw script.' not found'
  endif
  unlet script

  if s:is_nvim
    exe 'vsplit term://'.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp_conda_uninstall'
  else
    exe 'vert '.s:is_shell.' '.s:plugin_path.'/install.sh --pdbpp_conda_uninstall'
  endif
endfunction
"}}}
""" executor#ToggleDebuggerDefine {{{
function! executor#ToggleDebuggerDefine()
  if g:executor_debugger_define == 1
    let g:executor_debugger_define = 0
    echohl MoreMsg | echom ' executor: ExecutorDefineDebugger OFF ' | echohl None
  elseif g:executor_debugger_define == 0
    let g:executor_debugger_define = 1
    echohl MoreMsg | echom ' executor: ExecutorDefineDebugger ON ' | echohl None
  endif
endfunction
"}}}
""" executor#ToggleDebuggerMapping {{{
function! executor#ToggleDebuggerMapping()
  """ define g:executor_toggle_debugger_mapping {{{
  call inputsave()
  echohl MoreMsg
  echom ' '
  echom ' 0.UNMAP 1.gdb(soon) 2.lldb(soon) 3.pdb 4.vimspector  '
  echohl None
  let g:executor_toggle_debugger_mapping =
        \ input(
        \ 'ENTER nummer: ')
  call inputrestore()
  "}}}
  """ g:executor_toggle_debugger_mapping == '' {{{
  if g:executor_toggle_debugger_mapping == ''
    return
  endif
  "}}}
  """ g:executor_toggle_debugger_mapping == 0 {{{
  if g:executor_toggle_debugger_mapping == 0
    echohl MoreMsg
    echom ' '
    echom ' executor: UNMAP DONE '
    echohl None
    tnoremap <silent> <TAB>u <NOP>
    tnoremap <silent> <TAB>d <NOP>
    tnoremap <silent> <TAB>r <NOP>
    tnoremap <silent> <TAB>q <NOP>
    tnoremap <silent> <TAB>n <NOP>
    tnoremap <silent> <TAB>h <NOP>
    tnoremap <silent> <TAB>w <NOP>
    tnoremap <silent> <TAB>c <NOP>
    tnoremap <silent> <TAB>s <NOP>
    tnoremap <silent> <TAB><UP> <NOP>
    tnoremap <silent> <TAB><DOWN> <NOP>
    tnoremap <silent> <TAB><RIGHT> <NOP>
    tnoremap <silent> <TAB><LEFT> <NOP>
    tnoremap <silent> <TAB>b <NOP>
    nnoremap <silent> <TAB>db <NOP>
    tnoremap <silent> <TAB>v <NOP>
    tnoremap <silent> <TAB>e <NOP>

    nnoremap <silent> <TAB>d <NOP>
    nnoremap <silent> <TAB>r <NOP>
    nnoremap <silent> <TAB>q <NOP>
    nnoremap <silent> <TAB>n <NOP>
    nnoremap <silent> <TAB><UP> <NOP>
    nnoremap <silent> <TAB><DOWN> <NOP>
    nnoremap <silent> <TAB><RIGHT> <NOP>
    nnoremap <silent> <TAB><LEFT> <NOP>
    nnoremap <silent> <TAB>dw <NOP>
    nnoremap <silent> <TAB>b <NOP>
    nnoremap <silent> <TAB>db <NOP>
    nnoremap <silent> <TAB>v <NOP>
    nnoremap <silent> <TAB>e <NOP>
  endif
  "}}}
  """ g:executor_toggle_debugger_mapping == 1 {{{
  if g:executor_toggle_debugger_mapping == 1
    echohl MoreMsg
    echom ' '
    echom ' executor: MAP gdb coming soon XD '
    echohl None
  endif
  "}}}
  """ g:executor_toggle_debugger_mapping == 2 {{{
  if g:executor_toggle_debugger_mapping == 2
    echohl MoreMsg
    echom ' '
    echom ' executor: MAP pdb DONE '
    echohl None
    tnoremap <silent> <TAB>u gui<CR>
    tnoremap <silent> <TAB>d run<Space>
    tnoremap <silent> <TAB>r restart<Space>
    tnoremap <silent> <TAB>q quit<CR>
    tnoremap <silent> <TAB>n next<CR>
    tnoremap <silent> <TAB>h help<CR>
    tnoremap <silent> <TAB>w where<CR>
    tnoremap <silent> <TAB>c continue<CR>
    tnoremap <silent> <TAB>s step<CR>
    tnoremap <silent> <TAB><UP> up<CR>
    tnoremap <silent> <TAB><DOWN> down<CR>
    tnoremap <silent> <TAB><RIGHT> next<CR>
    tnoremap <silent> <TAB><LEFT> reteval<CR>
    tnoremap <silent> <TAB>b break<Space>
    tnoremap <silent> <TAB>v jump<CR>
    tnoremap <silent> <TAB>e p<Space>
  endif
  "}}}
  """ g:executor_toggle_debugger_mapping == 3 {{{
  if g:executor_toggle_debugger_mapping == 3
    echohl MoreMsg
    echom ' '
    echom ' executor: MAP pdb DONE '
    echohl None
    tnoremap <silent> <TAB>u sticky<CR>
    tnoremap <silent> <TAB>d run<Space>
    tnoremap <silent> <TAB>r restart<Space>
    tnoremap <silent> <TAB>q quit<CR>
    tnoremap <silent> <TAB>n next<CR>
    tnoremap <silent> <TAB>h help<CR>
    tnoremap <silent> <TAB>w where<CR>
    tnoremap <silent> <TAB>c continue<CR>
    tnoremap <silent> <TAB>s step<CR>
    tnoremap <silent> <TAB><UP> up<CR>
    tnoremap <silent> <TAB><DOWN> down<CR>
    tnoremap <silent> <TAB><RIGHT> next<CR>
    tnoremap <silent> <TAB><LEFT> reteval<CR>
    tnoremap <silent> <TAB>b break<Space>
    nnoremap <silent> <TAB>db clear<CR>
    tnoremap <silent> <TAB>v jump<CR>
    tnoremap <silent> <TAB>e p<Space>
  endif
  "}}}
  """ g:executor_toggle_debugger_mapping == 4 {{{
  if g:executor_toggle_debugger_mapping == 4
    echohl MoreMsg
    echom ' '
    echom ' executor: MAP vimspector DONE '
    echohl None
    nnoremap <silent> <TAB>d :call vimspector#Launch()<CR>
    nnoremap <silent> <TAB>r :call vimspector#Restart()<CR>
    nnoremap <silent> <TAB>q :call vimspector#Reset()<CR>
    nnoremap <silent> <TAB>n :call vimspector#Continue()<CR>
    nnoremap <silent> <TAB><UP> :call vimspector#StepOut()<CR>
    nnoremap <silent> <TAB><DOWN> :call vimspector#StepInto()<CR>
    nnoremap <silent> <TAB><RIGHT> :call vimspector#StepOver()<CR>
    nnoremap <silent> <TAB><LEFT> :call vimspector#AddWatch( expand( '<cexpr>' ) )<CR>
    nnoremap <silent> <TAB>dw :call vimspector#DeleteWatch()<CR>
    nnoremap <silent> <TAB>b :call vimspector#ToggleBreakpoint()<CR>
    nnoremap <silent> <TAB>db :call vimspector#ClearBreakpoints()<CR>
    nnoremap <silent> <TAB>v :call vimspector#RunToCursor()<CR>
    nnoremap <silent> <TAB>e :<c-u>call vimspector#Evaluate( expand( '<cexpr>' ) )<CR>
  endif
  "}}}
endfunction
"}}}
""" executor#Debugger {{{
function! executor#Debugger()
  if g:executor_debugger_define == 1
    call inputsave()
    let s:debugger_confirm = input('Define debugger? (y/n): ')
    call inputrestore()

    if !(s:debugger_confirm ==? "y" || s:debugger_confirm ==? "\r")
      return
    endif

    call inputsave()
    let s:debugger_define =
          \ input(
          \ 'Enter debugger, example: gdb (Linux), lldb (MacOS), python -m pdb, etc: ')
    call inputrestore()

    if s:debugger_define == ''
      return
    else
      if g:executor_input_args == 1
        let g:executor_program_args = executor#Args()
      elseif g:executor_input_args == 0
        let g:executor_program_args = ''
      endif

      if &filetype ==# 'c' || &filetype ==# 'cpp'
        if s:is_nvim
            exe 'vsplit term://'.s:debugger_define.' %<.x '.g:executor_program_args
        else
          execute 'vert term '.s:debugger_define.' %<.x '.g:executor_program_args
        endif
      else
        if s:is_nvim
            exe 'vsplit term://'.s:debugger_define.' % '.g:executor_program_args
        else
          execute 'vert term '.s:debugger_define.' % '.g:executor_program_args
        endif
      endif
    endif
  endif

  if g:executor_debugger_define == 0
    if &filetype ==# 'python'
      call executor#python#debuggerpdbpp()
    endif
  endif
endfunction
"}}}
""" executor#OpenTerminalVert {{{
function! executor#OpenTerminalVert()
  if s:is_nvim
    exe "vsplit term://".s:is_shell
  else
    exe "vert ".s:is_shell
  endif
endfun
"}}}
""" executor#OpenTerminal {{{
function! executor#OpenTerminal()
  if s:is_nvim
    setlocal splitright
    setlocal splitbelow
    exe "split term://".s:is_shell
  else
    exe "belowright ".s:is_shell
  endif
endfunction
"}}}
""" executor#OpenTerminalVSC {{{
function! executor#OpenTerminalVSC()
  if s:is_nvim
    setlocal splitright
    setlocal splitbelow
    exe "split term://".s:is_shell
    resize 10
  else
    exe "belowright ".s:is_shell
    resize 10
  endif
endfunction
"}}}
""" executor#ToggleResizeWindows {{{
fu! s:ResizeOn()
  echoh MoreMsg | echon 'executor: ExecutorResizeWindows ON' | echoh None
  let s:executor_resize_windows = 0
  map <UP> 3<C-w>-
  map <DOWN> 3<C-w>+
  map <RIGHT> 3<C-w>>
  map <LEFT> 3<C-w><
  map k 3<C-w>-
  map j 3<C-w>+
  map l 3<C-w>>
  map h 3<C-w><
endf
fu! s:ResizeOff()
  echoh MoreMsg | echon 'executor: ExecutorResizeWindows OFF' | echoh None
  let s:executor_resize_windows = 1
  unmap <UP>
  unmap <DOWN>
  unmap <LEFT>
  unmap <RIGHT>
  unmap k
  unmap j
  unmap l
  unmap h
endf
fun! executor#ToggleResizeWindows()
	if s:executor_resize_windows
    call s:ResizeOn()
  else
    call s:ResizeOff()
  endif
endfun
let s:executor_resize_windows = 1
"}}}
""" execute#Run {{{
function! executor#Run()
  if &filetype ==# 'python'
    call executor#python#run()
  elseif &filetype ==# 'c'
    call executor#c#run()
  elseif &filetype ==# 'cpp'
    call executor#cpp#run()
  elseif &filetype ==# 'sh'
    call executor#sh#run()
  elseif &filetype ==# 'r'
    call executor#r#run()
  elseif &filetype ==# 'tex' || &filetype ==# 'plaintex'
    call executor#latex#run()
  elseif &filetype ==# 'markdown' || &filetype ==# 'vimwiki'
    call executor#markdown#run()
  elseif &filetype ==# 'html' || &filetype ==# 'css'||
        \ &filetype ==# 'javascript'
    call executor#html#run()
  endif
endfun
"}}}
""" execute#Compiler {{{
function! executor#Compiler()
  if &filetype ==# 'python'
    call executor#python#run()
  elseif &filetype ==# 'c'
    call executor#c#compiler()
  elseif &filetype ==# 'cpp'
    call executor#cpp#compiler()
  elseif &filetype ==# 'sh'
    call executor#sh#run()
  elseif &filetype ==# 'r'
    call executor#r#run()
  elseif &filetype ==# 'tex' || &filetype ==# 'plaintex'
    call executor#latex#compiler()
  elseif &filetype ==# 'markdown' || &filetype ==# 'vimwiki'
    call executor#markdown#run()
  elseif &filetype ==# 'html'|| &filetype ==# 'css' ||
        \ &filetype ==# 'javascript'
    call executor#html#run()
  endif
endfun
"}}}
""" execute#Clean {{{
function! executor#Clean()
  if &filetype ==# 'python'
      let s:clean = get(s:, 'clean', '__pycache__')
  elseif &filetype ==# 'c'
      let s:clean = get(s:, 'clean', '%<.x.dSYM %<.x')
  elseif &filetype ==# 'cpp'
      let s:clean = get(s:, 'clean', '%<.x.dSYM %<.x')
  elseif &filetype ==# 'r'
      let s:clean = get(s:, 'clean', '%<.png')
  elseif &filetype ==# 'tex' || &filetype ==# 'plaintex'
      let s:clean = get(s:, 'clean', '%<.pdf %<.log %<.aux')
  endif

  if !exists('s:clean')
    let s:clean = get(s:, 'clean', '')
  endif

  if s:clean == ''
    call inputsave()
    let s:items_to_remove = input('Add items to remove? (y/n): ')
    call inputrestore()

    if !(s:items_to_remove ==? "y" || s:items_to_remove ==? "\r")
      return
    endif

    call inputsave()
    let s:clean = input('Enter items: ')
    call inputrestore()

    if s:clean == ''
      return
    endif
  endif

  if s:is_nvim
    exe "vsplit term://rm -vr ".s:clean
  else
    exe "vert term rm -vr ".s:clean
  endif

  if !exists('g:executor_clean')
    unlet s:clean
  endif
endfun
"}}}
""" executor#Zoom {{{
function! executor#Zoom(zoom)
  if exists("t:restore_zoom") && (a:zoom == v:true || t:restore_zoom.win != winnr())
    exec t:restore_zoom.cmd
    unlet t:restore_zoom
    echohl MoreMsg | echon 'executor: ExecutorZoom restored' | echohl None
  elseif a:zoom
    let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
    exec "normal \<C-W>\|\<C-W>_"
    echohl MoreMsg | echon 'executor: ExecutorZoom' | echohl None
  endif
endfunction
augroup Zoom
  au!
  au WinEnter * silent! :call executor#Zoom(v:false)
augroup END
"}}}
""" executor#Menu {{{
function! executor#Menu()
  call inputsave()
  echohl MoreMsg
  echom ' '
  echom "Date: "strftime("%H:%M %d.%B.%Y")
  echom "==========================================="
  " echom "| Program: Executor                               |"
  " echom "| Author: Marcos Chow Castro                      |"
  " echom "| Email: mctechnology170318@gmail.com             |"
  " echom "| GitHub: https://github.com/mctechnology17       |"
  " echom "| Brief: Multilanguage code executor              |"
  echom "|     █▀▀ ▀▄▀ █▀▀ █▀▀ █░█ ▀█▀ █▀█ █▀█     |"
  echom "|     ██▄ █░█ ██▄ █▄▄ █▄█ ░█░ █▄█ █▀▄     |"
  echom "|-----------------------------------------|"
  echom '| 1.Run                   11.TerminalVSC  |'
  echom '| 2.Compiler              12.Terminal     |'
  echom '| 3.Debugger              13.TerminalVert |'
  echom '| 4.ToogleDebuggerDefine  14.Zoom         |'
  echom '| 5.ToggleDebuggerMapping 15.Clean        |'
  echom '| 6.ToggleArgs            16.WinBar       |'
  echom '| 7.ToggleResizeWindows   17.Command      |'
  echom '| 8.InstallPDBPP                          |'
  echom '| 9.InstallPDBPPConda                     |'
  echom '| 10.KillAllBuffers                       |'
  echom "|-----------------------------------------|"
  echom '|              ENTER TO EXIT              |'
  echom "|-----------------------------------------|"
  echohl None
  let s:executor_dialer = input('Enter number: ')
  call inputrestore()
  if s:executor_dialer == ''
    return
  elseif s:executor_dialer == 1
    call executor#Run()
  elseif s:executor_dialer == 2
    call executor#Compiler()
  elseif s:executor_dialer == 3
    call executor#Debugger()
  elseif s:executor_dialer == 4
    call executor#ToggleDebuggerDefine()
  elseif s:executor_dialer == 5
    call executor#ToggleDebuggerMapping()
  elseif s:executor_dialer == 6
    call executor#ToggleArgs()
  elseif s:executor_dialer == 7
    call executor#ToggleResizeWindows()
  elseif s:executor_dialer == 8
    call executor#InstallPDBPP()
  elseif s:executor_dialer == 9
    call executor#InstallPDBPPConda()
  elseif s:executor_dialer == 10
    call executor#KillAllBuffers()
  elseif s:executor_dialer == 11
    call executor#OpenTerminalVSC()
  elseif s:executor_dialer == 12
    call executor#OpenTerminal()
  elseif s:executor_dialer == 13
    call executor#OpenTerminalVert()
  elseif s:executor_dialer == 14
    call executor#Zoom(v:true)
  elseif s:executor_dialer == 15
    call executor#Clean()
  elseif s:executor_dialer == 16
    call executor#WinBar()
  elseif s:executor_dialer == 17
    call executor#Command()
  " elseif s:executor_dialer == 17
    " call executor#UninstallPDBPP()
  " elseif s:executor_dialer == 18
    " call executor#UninstallPDBPPConda()
  " elseif s:executor_dialer == 19
    " call executor#Menu()
  " elseif s:executor_dialer == 20
    " call executor#Config()
  endif
endfunction
"}}}
""" executor#WinBar {{{
function! executor#WinBar()
  nnoremenu WinBar.  :call executor#Menu()<CR>
  nnoremenu WinBar.▶ :call executor#Run()<CR>
  nnoremenu WinBar. :call executor#Compiler()<CR>
  nnoremenu WinBar.ﴫ :call executor#Debugger()<CR>
  nnoremenu WinBar.ﴫ\  :call executor#ToggleDebuggerDefine()<CR>
  nnoremenu WinBar.ᗧ•••ᗣ  :call executor#ToggleArgs()<CR>
  nnoremenu WinBar. :call executor#Command()<CR>
  nnoremenu WinBar.﯊ :call executor#Clean()<CR>
  nnoremenu WinBar. :aunmenu WinBar<CR>
endfunction
"}}}
""" .executor.vim {{{
function! executor#Config()
  if filereadable(".executor.vim")
    source .executor.vim
  endif

  if !filereadable(".executor.vim")
    call inputsave()
    let s:executor_config = input('.executor.vim does not exist in the current directory, create? (y/n): ')
    call inputrestore()
    if s:executor_config == ''
      return
    elseif (s:executor_config ==? "y" || s:executor_config ==? "\r")
      execute 'edit .executor.vim'
    else
      return
    endif
  endif
endfunction
"}}}
""" executor#Command {{{
function executor#Command()
  let g:executor_program_args = executor#Args()
  if g:executor_program_args == ''
    return
  endif
  if s:is_nvim
     exe 'vsplit term://'.g:executor_program_args
  else
    exe 'vert term ++shell '.g:executor_program_args
  endif
endfunction
"}}}

" vim: set fdm=marker:
