#!/bin/zsh

# OpenStack: https://gitlab.com/gbraad/openstack-client
alias stack='docker run -it --rm -v $PWD:/workspace -v ~/.stack:/root/.stack registry.gitlab.com/gbraad/openstack-client:centos stack'
alias openstack='docker run -it --rm -v $PWD:/workspace -v ~/.config/openstack:/root/.config/openstack registry.gitlab.com/gbraad/openstack-client:centos openstack'

# Kubernetes
alias kubectl='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/kubernetes-client:fedora kubectl'

# devenv: https://gitlab.com/gbraad/devenv
alias devenv='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/devenv:f24'

# pandoc: https://gitlab.com/gbraad/docugen
alias pandoc='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/docugen pandoc'

# others
alias youtube-dl='docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl'

# nginx
alias nginx-pwd='docker run --name nginx-pwd -p 80:80 -v $PWD:/usr/share/nginx/html:ro -d nginx'

# Mono / PowerShell
alias posh='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/mono:c7'
