#!/bin/zsh
alias stack='docker run -it --rm -v ~/.stack:/root/.stack gbraad/openstack-client:centos stack'
alias openstack='docker run -it --rm gbraad/openstack-client:centos openstack'
