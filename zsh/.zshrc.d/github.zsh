#!/bin/zsh


_ghcr_login() {
  podman login ghcr.io -u USERNAME -p "$(secrets get ghcr_pat)"
}
alias ghcr-login=_ghcr_login
