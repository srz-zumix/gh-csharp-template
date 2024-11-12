#!/usr/bin/env bash

##########
# utils
##########

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd -P)

# shellcheck disable=SC2034
CACHE_DIR=$(cd "$(dirname "${SCRIPT_DIR}/../cache/.gitkeep")" &>/dev/null && pwd -P)

# shellcheck disable=SC2120
lower() {
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" ] && [ -r "$1" ]; then
            cat "$1"
        else
            echo "$1"
        fi
    else
        return 1
    fi | tr "[:upper:]" "[:lower:]"
}

ostype() {
    # shellcheck disable=SC2119
    uname | lower
}

os_detect() {
    export OS_DETECT_PLATFORM
    case "$(ostype)" in
        *'linux'*)  OS_DETECT_PLATFORM='linux'   ;;
        *'darwin'*) OS_DETECT_PLATFORM='osx'     ;;
        *'bsd'*)    OS_DETECT_PLATFORM='bsd'     ;;
        *'msys'*)   OS_DETECT_PLATFORM='windows' ;;
        *'cygwin'*) OS_DETECT_PLATFORM='windows' ;;
        *'mingw'*)  OS_DETECT_PLATFORM='windows' ;;
        *)          OS_DETECT_PLATFORM='unknown' ;;
    esac
}

is_osx() {
    os_detect
    if [ "$OS_DETECT_PLATFORM" = "osx" ]; then
        return 0
    else
        return 1
    fi
}
alias is_mac=is_osx

is_linux() {
    os_detect
    if [ "$OS_DETECT_PLATFORM" = "linux" ]; then
        return 0
    else
        return 1
    fi
}

is_windows() {
    os_detect
    if [ "$OS_DETECT_PLATFORM" = "windows" ]; then
        return 0
    else
        return 1
    fi
}

sh_detect() {
  export SHELL_TYPE
  if [ -n "${BASH_VERSION-}" ]; then
    SHELL_TYPE='bash'
  fi
  if [ -n "${ZSH_VERSION-}" ]; then
    SHELL_TYPE='zsh'
  fi
}

is_bash() {
  sh_detect
  if [ "$SHELL_TYPE" = "bash" ]; then
      return 0
  else
      return 1
  fi
}

is_zsh() {
  sh_detect
  if [ "$SHELL_TYPE" = "zsh" ]; then
      return 0
  else
      return 1
  fi
}

has_zsh() {
  if (type "zsh" > /dev/null 2>&1); then
    return 0
  else
    return 1
  fi
}


msg() {
    echo >&2 -e "${1-}"
}

die() {
    local msg=$1
    local code=${2-1} # default exit status 1
    msg "$msg"
    exit "$code"
}
