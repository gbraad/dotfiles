#!/bin/zsh

# OpenStack: https://gitlab.com/gbraad/openstack-client
alias stack='docker run -it --rm -v $PWD:/workspace -v ~/.stack:/root/.stack registry.gitlab.com/gbraad/openstack-client:centos stack'
alias openstack='docker run -it --rm -v $PWD:/workspace -v ~/.config/openstack:/root/.config/openstack registry.gitlab.com/gbraad/openstack-client:centos openstack'

# Kubernetes: https://gitlab.com/gbraad/kubernetes-client
#alias kubectl='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/kubernetes-client:fedora kubectl'
# https://gitlab.com/gbraad/flatpak-kubernetes-client
alias kubectl='flatpak run nl.gbraad.KubernetestClient'

# OpenShift: https://gitlab.com/gbraad/flatpak-openshift-client
alias oc='flatpak run nl.gbraad.OpenShiftClient'

# devenv: https://gitlab.com/gbraad/devenv
alias devenv='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/devenv:f24'

# c9ide: https://gitlab.com/gbraad/c9ide
alias c9ide='docker run -it --rm -v `pwd`:/workspace registry.gitlab.com/gbraad/c9ide:f24'

# pandoc: https://gitlab.com/gbraad/docugen
alias pandoc='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/docugen pandoc'

# Mono / PowerShell: https://gitlab.com/gbraad/mono
alias posh='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/mono:c7'

# Python, etc
# jupyter: https://gitlab.com/gbraad/jupyter
alias jupyter='docker run -it --rm -v $PWD:/workspace -p 8888:8888 registry.gitlab.com/gbraad/jupyter:f24 jupyter'

# Flatpak
alias flatpak-builder-gnome='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/flatpak-builder-gnome bash'
alias flatpak-builder-freedesktop='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/flatpak-builder-desktop bash'

# LibreOffice (convert: --headless --convert-to odt *.docx)
#alias libreoffice='docker run --rm -v $PWD:/workspace registry.gitlab.com/gbraad/libreoffice:latest libreoffice'
alias libreoffice='flatpak run org.libreoffice.LibreOffice'
#alias=libreoffice='docker run -v $PWD:/workspace registry.gitlab.com/gbraad/libreoffice:latest flatpak run org.libreoffice.LibreOffice'

# others
alias youtube-dl='docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl'
alias nginx-pwd='docker run --name nginx-pwd -p 80:80 -v $PWD:/usr/share/nginx/html:ro -d nginx'
