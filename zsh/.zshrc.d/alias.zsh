#!/bin/zsh
alias dotup='cd ~/.dotfiles && git pull && cd -'

# LibreOffice (convert: --headless --convert-to odt *.docx)
alias libreoffice='flatpak run org.libreoffice.LibreOffice'

# Sublime Text
alias st='/opt/sublime_text_3/sublime_text $PWD'

# colorized cat
alias ccat='pygmentize -g -O style=tomorrownightbright,linenos=1'

