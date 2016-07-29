#!/bin/zsh

# OpenStack: https://gitlab.com/gbraad/openstack-client
alias stack='docker run -it --rm -v ~/.stack:/root/.stack registry.gitlab.com/gbraad/openstack-client:centos stack'
alias openstack='docker run -it --rm -v ~/.config/openstack:/root/.config/openstack registry.gitlab.com/gbraad/openstack-client:centos openstack'

# devenv: https://gitlab.com/gbraad/devenv
alias devenv='docker run -it --rm -v `pwd`:/workspace registry.gitlab.com/gbraad/devenv:f24'

# pandoc: https://gitlab.com/gbraad/docugen
alias pandoc='docker run -it --rm registry.gitlab.com/gbraad/docugen pandoc'

# others
alias youtube-dl='docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl'

# nginx
alias nginx-root='docker run --name nginx-root -p 80:80 -v /var/srv:/usr/share/nginx/html:ro -d nginx'
