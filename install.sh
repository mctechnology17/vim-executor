#!/usr/bin/env bash
# ========================================
# FileName: install.sh
# Date: 21:53 13.April.2022
# Author: Marcos Chow Castro
# Email: mctechnology170318@gmail.com
# GitHub: https://github.com/mctechnology17
# Brief: <brief>
# =========================================
# set -x
# TODO: comprobar todos los interpretes para Compiler, CleanUp y RunFile
### colors {{{
BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"
#}}}
### basic functions {{{
info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}
warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}
error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}
completed() {
  printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}
has() {
  command -v "$1" 1>/dev/null 2>&1
}
#}}}
### main {{{
info 'Processing data...'
### pdbpp un/install {{{
if [ "$1" = "--pdbpp" ]; then
  if ! has pip; then
    error 'Could not find the command "pip"'
    exit 1
  fi
  pip install pdbpp
elif [ "$1" = "--pdbpp_uninstall" ]; then
  if ! has pip; then
    error 'Could not find the command "pip"'
    exit 1
  fi
  pip uninstall pdbpp
elif [ "$1" = "--pdbpp_conda" ]; then
  if ! has conda; then
    error 'Could not find the command "conda"'
    exit 1
  fi
  conda install -c conda-forge pdbpp
elif [ "$1" = "--pdbpp_conda_uninstall" ]; then
  if ! has conda; then
    error 'Could not find the command "conda"'
    exit 1
  fi
  conda remove pdbpp
#}}}
else
  info 'No change made!'
  exit 1
fi
#}}}
# set +x

# vim: set sw=2 ts=2 sts=2 et ft=sh fdm=marker:
