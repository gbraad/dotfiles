#!/bin/zsh
CONTAINER_RUNTIME="${1:-podman}"

# pandoc: https://gitlab.com/gbraad/docugen
alias pandoc='${CONTAINER_RUNTIME} run -it --rm -v $PWD:/workspace ghcr.io/gbraad/docugen pandoc'

# LibreOffice (convert: --headless --convert-to odt *.docx)
#alias libreoffice='${CONTAINER_RUNTIME} run --rm -v $PWD:/workspace registry.gitlab.com/gbraad/libreoffice:latest libreoffice'
#alias=libreoffice='${CONTAINER_RUNTIME} run -v $PWD:/workspace registry.gitlab.com/gbraad/libreoffice:latest flatpak run org.libreoffice.LibreOffice'

# others
alias youtube-dl='${CONTAINER_RUNTIME} run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl'
alias nginx-pwd='${CONTAINER_RUNTIME} run --name nginx-pwd -p 80:80 -v $PWD:/usr/share/nginx/html:ro -d nginx'

# Steam powered
alias steamcmd='${CONTAINER_RUNTIME} run -it -v $HOME/Steam:/home/user/Steam registry.gitlab.com/gbraad/steamcmd:latest'

# hostenter
alias hostenter='${CONTAINER_RUNTIME} run --rm -it --privileged --pid=host gbraad/hostenter /bin/bash'

# --- Fedora devenv --- https://github.com/gbraad-devenv/fedora

# dotfiles
alias devenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/fedora/dotfiles:37 /bin/zsh'

# systemd
alias devsys='podman run -d --name=devsys --hostname $HOSTNAME-devsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/fedora/systemd:37'
alias devdock='docker run -d --name=devsys --hostname $HOSTNAME-devsys --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/fedora/dotfiles:37 sleep infinity'
alias devroot='${CONTAINER_RUNTIME} exec -it devsys /bin/zsh'
alias devuser='${CONTAINER_RUNTIME} exec -it devsys su - gbraad'

# ---

# fedora coreos
alias fcos='podman run -d --name=fcos --hostname $HOSTNAME-fcos --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun quay.io/fedora/fedora-coreos:stable /sbin/init'
alias fcosroot='${CONTAINER_RUNTIME} exec -it fcos /bin/bash'

# --- Debian devenv --- https://github.com/gbraad-devenv/debian/

# dotfiles
alias debenv='${CONTAINER_RUNTIME} run -it --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun --rm -v $HOME/Projects:/home/${USER}/Projects --entrypoint="" ghcr.io/gbraad-devenv/debian/dotfiles:bullseye /bin/zsh'

# systemd
alias debsys='podman run -d --name=debsys --hostname $HOSTNAME-debsys --systemd=always --cap-add=NET_ADMIN --cap-add=NET_RAW --device=/dev/net/tun -v $HOME/Projects:/home/${USER}/Projects ghcr.io/gbraad-devenv/debian/systemd:bullseye'
alias debroot='${CONTAINER_RUNTIME} exec -it debsys /bin/zsh'
alias debuser='${CONTAINER_RUNTIME} exec -it debsys su - gbraad'
