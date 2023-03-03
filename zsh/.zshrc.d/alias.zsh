#!/bin/zsh
alias dotup='cd ~/.dotfiles && git pull && cd -'

CONTAINER_RUNTIME="${1:-podman}"

# pandoc: https://gitlab.com/gbraad/docugen
alias pandoc='${CONTAINER_RUNTIME} run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/docugen pandoc'

# LibreOffice (convert: --headless --convert-to odt *.docx)
#alias libreoffice='${CONTAINER_RUNTIME} run --rm -v $PWD:/workspace registry.gitlab.com/gbraad/libreoffice:latest libreoffice'
alias libreoffice='flatpak run org.libreoffice.LibreOffice'
#alias=libreoffice='${CONTAINER_RUNTIME} run -v $PWD:/workspace registry.gitlab.com/gbraad/libreoffice:latest flatpak run org.libreoffice.LibreOffice'

# others
alias youtube-dl='${CONTAINER_RUNTIME} run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl'
alias nginx-pwd='${CONTAINER_RUNTIME} run --name nginx-pwd -p 80:80 -v $PWD:/usr/share/nginx/html:ro -d nginx'

# Sublime Text
alias st='/opt/sublime_text_3/sublime_text $PWD'

# Steam powered
alias steamcmd='${CONTAINER_RUNTIME} run -it -v $HOME/Steam:/home/user/Steam registry.gitlab.com/gbraad/steamcmd:latest'

# hostenter
alias hostenter='${CONTAINER_RUNTIME} run --rm -it --privileged --pid=host gbraad/hostenter /bin/bash'

# colorized cat
alias ccat='pygmentize -g -O style=tomorrownightbright,linenos=1'

# devenv
alias devenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad/devenv/dotfiles:37 /bin/zsh'

# devenv systemd
alias devsys='podman run -d --name=devsys --hostname $HOSTNAME-devsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad/devenv/systemd:37'
alias devdock='docker run -d --name=devsys --hostname $HOSTNAME-devsys --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad/devenv/dotfiles:37 sleep infinity'
alias devroot='${CONTAINER_RUNTIME} exec -it devsys /bin/zsh'
alias devuser='${CONTAINER_RUNTIME} exec -it devsys su - gbraad'
