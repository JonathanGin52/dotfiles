#!/usr/bin/env sh

OS=""
if [ -f /etc/lsb-release ]; then
  # shellcheck disable=SC1091
  . /etc/lsb-release
  OS="${DISTRIB_ID:-Ubuntu}"
elif [ "$(uname -s)" = "Darwin" ]; then
  OS="macos"
fi 
case "$(uname -n)" in codespace*)
  OS="codespace"
  ;;
esac
echo "$OS"
