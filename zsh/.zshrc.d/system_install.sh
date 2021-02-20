if [ ! -z ${SYSTEM_INSTALL+x} ]; then

   # essentials
   sudo dnf install -y \
        mc vim tmux screen links lynx z

   # powerline
   sudo dnf install -y \
        powerline vim-powerline tmux-powerline

   # fonts
   sudo dnf install -y \
        adobe-source-han-mono-fonts \
        adobe-source-code-pro-fonts \
        adobe-source-sans-pro \
        adobe-source-serif-pro-fonts \
        powerline-fonts

   # optiona
   sudo dnf install -y \
        python3-pygments
   pip install pygments-style-tomorrownightbright

   # vim
   sudo dnf install -y \
        vim-syntastic-asciidoc \
        vim-syntastic-html \
        vim-syntastic-css \
        vim-syntastic-vim \
        vim-syntastic-yaml \
        vim-syntastic-json \
        vim-syntastic-go \
        vim-syntastic-javascript \
        vim-syntastic-zsh \
        vim-airline \
        vim-go \
        vim-ctrlp \
        vim-gitgutter \
        vim-fugitive \
        vim-nerdtree

   # graphical
   sudo dnf install -y \
        i3 \
        feh

   unset SYSTSEM_INSTALL
fi
