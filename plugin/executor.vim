"=========================================
" FileName: executor.vim
" Date: 21:42 11.April.2022
" Author: Marcos Chow Castro
" Email: mctechnology170318@gmail.com
" GitHub: https://github.com/mctechnology17
" Brief: <brief>
"==========================================
scriptencoding utf-8
""" g:executor_enable {{{
if exists('g:executor_enable')
  finish
endif
let g:executor_enable = get(g:, 'executor_enable', 1)
" TODO: windows support comming soon
" let s:is_win=expand(has('win32')||has('win64')||has("win16")||has("win95"))
" if s:is_win && !has('win32unix')
  " echohl Error
  " echom 'executor: Windows system no supported for this feature'
  " echohl None
  " finish
" endif
"}}}
""" MAPPING:
""" g:executor_esc {{{
if !exists('g:executor_esc')
  let g:executor_esc =
        \ get(g:, 'executor_esc', 2)
endif
"}}}
""" g:executor_jump {{{
if !exists('g:executor_jump')
  let g:executor_jump =
        \ get(g:, 'executor_jump', 1)
endif
"}}}
""" g:executor_file_mapping {{{
if !exists('g:executor_file_mapping')
  let g:executor_file_mapping =
        \ get(g:, 'executor_file_mapping', 1)
endif
"}}}
""" g:executor_winbar {{{
if !exists('g:executor_winbar')
  let g:executor_winbar =
        \ get(g:, 'executor_winbar', 1)
endif
"}}}
""" DEBUGGER:
""" g:executor_debugger_define {{{
if !exists('g:executor_debugger_define')
  let g:executor_debugger_define =
        \ get(g:, 'executor_debugger_define', 0)
endif
"}}}
""" g:executor_debugger_flags_c {{{
if !exists('g:executor_debugger_flags_c')
  let g:executor_debugger_flags_c =
        \ get(g:, 'executor_debugger_flags_c', '')
endif
"}}}
""" g:executor_debugger_flags_cpp {{{
if !exists('g:executor_debugger_flags_cpp')
  let g:executor_debugger_flags_cpp =
        \ get(g:, 'executor_debugger_flags_cpp', '')
endif
"}}}
""" g:executor_debugger_flags_python {{{
if !exists('g:executor_debugger_flags_python')
  let g:executor_debugger_flags_python =
        \ get(g:, 'executor_debugger_flags_python', '-m')
endif
"}}}
""" g:executor_debugger_flags_latex {{{
if !exists('g:executor_debugger_flags_latex')
  let g:executor_debugger_flags_latex =
        \ get(g:, 'executor_debugger_flags_latex', '')
endif
"}}}
""" g:executor_debugger_flags_r {{{
if !exists('g:executor_debugger_flags_r')
  let g:executor_debugger_flags_r =
        \ get(g:, 'executor_debugger_flags_r', '')
endif
"}}}
""" g:executor_debugger_flags_sh {{{
if !exists('g:executor_debugger_flags_sh')
  let g:executor_debugger_flags_sh =
        \ get(g:, 'executor_debugger_flags_sh', '')
endif
"}}}
""" COMPILER:
""" g:executor_compiler_run_code {{{
if !exists('g:executor_compiler_run_code')
  let g:executor_compiler_run_code =
        \ get(g:, 'executor_compiler_run_code', 0)
endif
"}}}
""" g:executor_compiler_flags_c {{{
if !exists('g:executor_compiler_flags_c')
  let g:executor_compiler_flags_c =
        \ get(g:, 'executor_compiler_flags_c',
        \ '-g -v -m64 -Wall -Werror -Wunused-parameter -Wunused-variable -O3 -pedantic')
endif
"}}}
""" g:executor_compiler_flags_cpp {{{
if !exists('g:executor_compiler_flags_cpp')
  let g:executor_compiler_flags_cpp =
        \ get(g:, 'executor_compiler_flags_cpp',
        \ '-g -v -m64 -Wall -Werror -Wunused-parameter -Wunused-variable -O3 -pedantic')
endif
"}}}
""" g:executor_compiler_flags_python {{{
if !exists('g:executor_compiler_flags_python')
  let g:executor_compiler_flags_python =
        \ get(g:, 'executor_compiler_flags_python', '')
endif
"}}}
""" g:executor_compiler_flags_latex {{{
if !exists('g:executor_compiler_flags_latex')
  let g:executor_compiler_flags_latex =
        \ get(g:, 'executor_compiler_flags_latex', '')
endif
"}}}
""" g:executor_compiler_flags_r {{{
if !exists('g:executor_compiler_flags_r')
  let g:executor_compiler_flags_r =
        \ get(g:, 'executor_compiler_flags_r', '--verbose')
endif
"}}}
""" g:executor_compiler_flags_sh {{{
if !exists('g:executor_compiler_flags_sh')
  let g:executor_compiler_flags_sh =
        \ get(g:, 'executor_compiler_flags_sh', '')
endif
"}}}
""" ARGUMENTS:
""" g:executor_input_args {{{
if !exists('g:executor_input_args')
  let g:executor_input_args =
        \ get(g:, 'executor_input_args', 0)
endif
"}}}
""" g:executor_program_args_c {{{
if !exists('g:executor_program_args_c')
  let g:executor_program_args_c =
        \ get(g:, 'executor_program_args_c', '')
endif
"}}}
""" g:executor_program_args_cpp {{{
if !exists('g:executor_program_args_cpp')
  let g:executor_program_args_cpp =
        \ get(g:, 'executor_program_args_cpp', '')
endif
"}}}
""" g:executor_program_args_python {{{
if !exists('g:executor_program_args_python')
  let g:executor_program_args_python =
        \ get(g:, 'executor_program_args_python', '')
endif
"}}}
""" g:executor_program_args_latex {{{
if !exists('g:executor_program_args_latex')
  let g:executor_program_args_latex =
        \ get(g:, 'executor_program_args_latex', '')
endif
"}}}
""" g:executor_program_args_r {{{
if !exists('g:executor_program_args_r')
  let g:executor_program_args_r =
        \ get(g:, 'executor_program_args_r', '')
endif
"}}}
""" g:executor_program_args_sh {{{
if !exists('g:executor_program_args_sh')
  let g:executor_program_args_sh =
        \ get(g:, 'executor_program_args_sh', '')
endif
"}}}
call executor#GlobalVariable()
""" COMMAND:
""" commands {{{
command! -nargs=0 ExecutorTerminalVert          call executor#OpenTerminalVert()
command! -nargs=0 ExecutorTerminal              call executor#OpenTerminal()
command! -nargs=0 ExecutorTerminalVSC           call executor#OpenTerminalVSC()
command! -nargs=0 ExecutorResizeWindows         call executor#ToggleResize()
command! -nargs=0 ExecutorDebugger              call executor#Debugger()
command! -nargs=0 ExecutorToggleDefineDebugger  call executor#ToggleDefineDebugger()
command! -nargs=0 ExecutorToggleDebuggerMapping call executor#ToggleDebuggerMapping()
command! -nargs=0 ExecutorInstallPDBPP          call executor#InstallPDBPP()
command! -nargs=0 ExecutorUninstallPDBPP        call executor#UninstallPDBPP()
command! -nargs=0 ExecutorInstallPDBPPConda     call executor#InstallPDBPPConda()
command! -nargs=0 ExecutorUninstallPDBPPConda   call executor#UninstallPDBPPConda()
command! -nargs=0 ExecutorRun                   call executor#Run()
command! -nargs=0 ExecutorClean                 call executor#Clean()
command! -nargs=0 ExecutorCompiler              call executor#Compiler()
command! -nargs=0 ExecutorZoom                  call executor#Zoom(v:true)
command! -nargs=0 ExecutorToggleArgs            call executor#ToggleArgs()
command! -nargs=0 ExecutorMenu                  call executor#Menu()
command! -nargs=0 ExecutorWinBar                call executor#WinBar()
command! -nargs=0 ExecutorConfig                call executor#Config()
command! ExecutorKillAllBuffers silent! execute "%bd|e#|bd#"
"}}}
""" WINBAR:
""" WinBar {{{
if g:executor_winbar == 1
  call executor#WinBar()
endif
"}}}

" vim: set fdm=marker:
