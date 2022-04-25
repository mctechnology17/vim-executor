"=========================================
" FileName: .executor.vim
" Date: 23:04 20.April.2022
" Author: Marcos Chow Castro
" Email: mctechnology170318@gmail.com
" GitHub: https://github.com/mctechnology17
" Brief: these are the default global variables, to disable something,
" simply change the value to 0 if the variable accepts integers.
" If the variable accepts strings then give it the value of ''
"==========================================
""" MAPPING:
" 1 = <ESC> 2 = <ESC><ESC> time to exit the terminal and enter normal mode
let g:executor_esc =
      \ get(g:, 'executor_esc', 2)
" 1 = <S-ARROWS> 2 = <LEADER><ARROWS> 3 = <C-HJKL>
let g:executor_jump =
      \ get(g:, 'executor_jump', 1)
" default mapping for various useful functions
" THERE IS NO OPTION TO CONFIGURE.
" map: cd -> change directory
" map: fi -> file identifier
" map: fl -> file list
" map: fs -> find string in all files in current directory
" map: fm -> file maximization
" map: fw -> file write
" map: fo -> file open from current directory
" map: fr -> file rename(curre buffer) like tmux
let g:executor_file_mapping =
      \ get(g:, 'executor_file_mapping', 1)
" activate and deactivate the WinBar. ONLY FOR VIM
let g:executor_winbar =
      \ get(g:, 'executor_winbar', 1)

""" DEBUGGER:
let g:executor_debugger_define =
      \ get(g:, 'executor_debugger_define', 0)
let g:executor_debugger_flags_c =
      \ get(g:, 'executor_debugger_flags_c', '')
let g:executor_debugger_flags_cpp =
      \ get(g:, 'executor_debugger_flags_cpp', '')
let g:executor_debugger_flags_python =
      \ get(g:, 'executor_debugger_flags_python', '-m')
let g:executor_debugger_flags_latex =
      \ get(g:, 'executor_debugger_flags_latex', '')
let g:executor_debugger_flags_r =
      \ get(g:, 'executor_debugger_flags_r', '')
let g:executor_debugger_flags_sh =
      \ get(g:, 'executor_debugger_flags_sh', '')

""" COMPILER:
" always ask if you want to define the debugger
let g:executor_compiler_run_code =
      \ get(g:, 'executor_compiler_run_code', 0)
let g:executor_compiler_flags_c =
      \ get(g:, 'executor_compiler_flags_c',
      \ '-g -v -m64 -Wall -Werror -Wunused-parameter -Wunused-variable -O3 -pedantic')
let g:executor_compiler_flags_cpp =
      \ get(g:, 'executor_compiler_flags_cpp',
      \ '-g -v -m64 -Wall -Werror -Wunused-parameter -Wunused-variable -O3 -pedantic')
let g:executor_compiler_flags_python =
      \ get(g:, 'executor_compiler_flags_python', '')
let g:executor_compiler_flags_latex =
      \ get(g:, 'executor_compiler_flags_latex', '')
let g:executor_compiler_flags_r =
      \ get(g:, 'executor_compiler_flags_r', '--verbose')
let g:executor_compiler_flags_sh =
      \ get(g:, 'executor_compiler_flags_sh', '')

""" ARGUMENTS:
" always ask if you want to define the arguments
let g:executor_input_args =
      \ get(g:, 'executor_input_args', 0)
let g:executor_program_args_c =
      \ get(g:, 'executor_program_args_c', '')
let g:executor_program_args_cpp =
      \ get(g:, 'executor_program_args_cpp', '')
let g:executor_program_args_python =
      \ get(g:, 'executor_program_args_python', '')
let g:executor_program_args_latex =
      \ get(g:, 'executor_program_args_latex', '')
let g:executor_program_args_r =
      \ get(g:, 'executor_program_args_r', '')
let g:executor_program_args_sh =
      \ get(g:, 'executor_program_args_sh', '')

""" COMMAND:
" open a vertical terminal
ExecutorTerminalVert          call executor#OpenTerminalVert()
" open a horizontal terminal
ExecutorTerminal              call executor#OpenTerminal()
" open a terminal with size proportional to the vscode terminal
ExecutorTerminalVSC           call executor#OpenTerminalVSC()
" toggle to resize windows
ExecutorToggleResizeWindows   call executor#ToggleResizeWindows()
" call debugger
ExecutorDebugger              call executor#Debugger()
" define the debugger
ExecutorToggleDefineDebugger  call executor#ToggleDefineDebugger()
" debugger mapping: 0.UNMAP 1.gdb 2.lldb 3.pdb 4.vimspector
ExecutorToggleDebuggerMapping call executor#ToggleDebuggerMapping()
" Mappgin for pdb option 3
" map: <TAB>u sticky<CR>
" map: <TAB>d run<Space>
" map: <TAB>r restart<Space>
" map: <TAB>q quit<CR>
" map: <TAB>n next<CR>
" map: <TAB>h help<CR>
" map: <TAB>w where<CR>
" map: <TAB>c continue<CR>
" map: <TAB>s step<CR>
" map: <TAB><UP> up<CR>
" map: <TAB><DOWN> down<CR>
" map: <TAB><RIGHT> next<CR>
" map: <TAB><LEFT> reteval<CR>
" map: <TAB>bb break<Space>
" map: <TAB>bc clear<CR>
" map: <TAB>v jump<CR>
" map: <TAB>e p<Space>
" Mappgin for vimspector option 4
" map: <TAB>d :call vimspector#Launch()<CR>
" map: <TAB>r :call vimspector#Restart()<CR>
" map: <TAB>q :call vimspector#Reset()<CR>
" map: <TAB>n :call vimspector#Continue()<CR>
" map: <TAB><UP> :call vimspector#StepOut()<CR>
" map: <TAB><DOWN> :call vimspector#StepInto()<CR>
" map: <TAB><RIGHT> :call vimspector#StepOver()<CR>
" map: <TAB><LEFT> :call vimspector#AddWatch( expand( '<cexpr>' ) )<CR>
" map: <TAB>dw :call vimspector#DeleteWatch()<CR>
" map: <TAB>bb :call vimspector#ToggleBreakpoint()<CR>
" map: <TAB>bc :call vimspector#ClearBreakpoints()<CR>
" map: <TAB>v :call vimspector#RunToCursor()<CR>
" map: <TAB>e :<c-u>call vimspector#Evaluate( expand( '<cexpr>' ) )<CR>
" install the debugger pdbpp with pip for python
ExecutorInstallPDBPP          call executor#InstallPDBPP()
" uninstall the debugger pdbpp
ExecutorUninstallPDBPP        call executor#UninstallPDBPP()
" install the debugger pdbpp with conda for python
ExecutorInstallPDBPPConda     call executor#InstallPDBPPConda()
" uninstall the debugger pdbpp
ExecutorUninstallPDBPPConda   call executor#UninstallPDBPPConda()
" run the code
ExecutorRun                   call executor#Run()
" clean object files: main.o, main.exe, pdf, __pycache__ etc
ExecutorClean                 call executor#Clean()
" compile the code
ExecutorCompiler              call executor#Compiler()
" zoom in the current window/buffer
ExecutorZoom                  call executor#Zoom(v:true)
" on/off argument input
ExecutorToggleArgs            call executor#ToggleArgs()
" call a menu
ExecutorMenu                  call executor#Menu()
" call the WinBar
ExecutorWinBar                call executor#WinBar()
" source a local config in your current directory
ExecutorConfig                call executor#Config()
" kill all buffers and keep the current buffer
ExecutorKillAllBuffers silent! execute "%bd|e#|bd#"

""" WINBAR:
" Winbar defaults. if you want to customize the winbar you can leave the
" corresponding variable for activation at 0, or simply add more options of
" your interest
nnoremenu WinBar.  :call executor#Menu()<CR>
nnoremenu WinBar.▶ :call executor#Run()<CR>
nnoremenu WinBar.⟲ :call executor#Compiler()<CR>
nnoremenu WinBar. :call executor#Debugger()<CR>
nnoremenu WinBar.\ ✔︎ :call executor#ToggleDefineDebugger()<CR>
nnoremenu WinBar.ᗧ•••ᗣ  :call executor#ToggleArgs()<CR>
nnoremenu WinBar. :call executor#OpenTerminalVSC()<CR>
nnoremenu WinBar.♻︎ :call executor#Clean()<CR>
nnoremenu WinBar.✕ :aunmenu WinBar<CR>

" vim: set fdm=marker:
