Gerard Braad's dotfiles
=======================

[!["Prompt"](https://raw.githubusercontent.com/gbraad/assets/gh-pages/icons/prompt-icon-64.png)](http://github.com/gbraadnl)

  `using Git and Stow`


Do not use this directly, but take parts and learn from it. I share it because
I got frustrated about moving a tarball around (and being scared of loosing
it). Which eventually happened when my notebook got stolen... so, this is not
an ideal solution yet. It only contains the basic from an old tarball, and still
needs all the customization for vim, emacs, etc. For now, No support, no comments,
nothing... "what you see is what it is"...


Requirements
------------

CentOS/Fedora
```
$ dnf install git tmux zsh mc stow python2
```

CentOS 8
```
$ dnf install epel-release python2
```

Debian/Ubuntu
```
$ apt-get install git tmux zsh mc stow
```

After this you can use GNU `stow` to install the dotfiles per application

```
$ git clone https://github.com/gbraad/dotfiles.git .dotfiles --recursive
$ cd .dotfiles
$ stow zsh
```

Installation
------------


```
$ curl -sSL https://raw.githubusercontent.com/gbraad/dotfiles/master/install.sh | sh
```


Usage
-----

  * ~~Used in my [C9](http://c9.io) workspaces~~
  * ~~[Developer environment](https://github.com/gbraad/devenv/) setup~~
  * Docker [developer environment](https://hub.docker.com/r/gbraad/devenv) image
  * Google Cloud Platform [cloud shell](https://console.cloud.google.com)
  * Windows Subsystem for Linux (WSL2); Bash on Ubuntu on Windows (WSL1)
  * Tested on: CentOS7+, Fedora 21+, and Ubuntu 14.04+
  * Cygwin64
  * Termux
  * ...


Authors
-------

| [!["Gerard Braad"](http://gravatar.com/avatar/e466994eea3c2a1672564e45aca844d0.png?s=60)](http://gbraad.nl "Gerard Braad <me@gbraad.nl>") |
|---|
| [@gbraad](https://twitter.com/gbraad)  |
