#!/bin/zsh

# pandoc: https://gitlab.com/gbraad/docugen
alias pandoc='docker run -it --rm -v $PWD:/workspace registry.gitlab.com/gbraad/docugen pandoc'

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

# Sublime Text
alias st='/opt/sublime_text_3/sublime_text $PWD'

# Steam powered
alias steamcmd='docker run -it -v $HOME/Steam:/home/user/Steam registry.gitlab.com/gbraad/steamcmd:latest'

# hostenter
alias hostenter='docker run --rm -it --privileged --pid=host gbraad/hostenter /bin/bash'

# colorized cat
alias ccat='pygmentize -g -O style=tomorrownightbright,linenos=1'
