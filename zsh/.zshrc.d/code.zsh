_installcode() {
    tempfile=$(mktemp)
    curl -fsSL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" -o ${tempfile}
    tar zxvf ${tempfile} -C ${HOME}/.local/bin
    rm -f ${tempfile}
}

alias install-code="_installcode"
