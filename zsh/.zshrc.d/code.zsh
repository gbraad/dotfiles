#!/bin/zsh

CONFIG="${HOME}/.code"
alias codeini="git config -f $CONFIG"

_codepath=$(codeini --get code.path) || _codepath="${HOME}/.local/bin"
eval _codepath=$(echo ${_codepath})

_codeexists() {
    if [ -f "${_codepath}/code" ]; then
        return 0  # File exists, return true (0)
    else
        return 1  # File does not exist, return false (1)
    fi
}

_installcode() {
    echo "Installing code-cli"
    # does not handle architecture yet

    tempfile=$(mktemp)
    curl -fsSL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" -o ${tempfile}
    tar -zxvf ${tempfile} -C ${_codepath} > /dev/null 2>&1
    rm -f ${tempfile}
}



_startcodetunnel() {
    if ! _codeexists; then
        _installcode
    fi

    screen "${_codepath}/code tunnel --accept-server-license-terms --name ${HOSTNAME}"
}

_startcodeserveweb() {
    if ! _codeexists; then
        _installcode
    fi

    screen "${_codepath}/code serve-web --without-connection-token --host 0.0.0.0"
}

alias install-code="_installcode"
alias start-code-tunnel="_startcodetunnel"
alias start-code-serveweb="_startcodeserveweb"

_installcodeifmissing() {
    if ! _codeexists; then
        _installcode
    fi
}

if [[ $(codeini --get "code.autoinstall") == true ]]; then
  _installcodeifmissing
fi
