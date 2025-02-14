Gerard Braad's dotfiles
=======================

[!["Prompt"](https://raw.githubusercontent.com/gbraad/assets/gh-pages/icons/prompt-icon-64.png)](http://github.com/gbraad)

  using `git`, `stow` and `zsh`


Do not use this directly, but take parts and learn from it. I share it because
I got frustrated about moving a tarball around (and being scared of losing
it). This eventually happened when my notebook got stolen... so, this is not
an ideal solution for you. Treat it as, "what you see is what it is"...

This forms the basis of my [development environment](https://github.com/gbraad-devenv/) images.


Requirements
------------

### CentOS/Fedora

```
$ dnf install git zsh stow
```

### CentOS 8 (powerline-local)

```
$ dnf install epel-release python2
```

### Debian/Ubuntu

```
$ apt-get install git zsh stow
```


Installation
------------

### Automated

```
$ curl -sSL https://raw.githubusercontent.com/gbraad/dotfiles/master/install.sh | sh
```

### Manual 
After setting up the requirements you can use GNU `stow` to install the dotfiles per application

```
$ git clone https://github.com/gbraad/dotfiles.git .dotfiles --recursive
$ cd .dotfiles
$ ./install.sh  # optional
$ stow zsh
```


Compatibility
-------------

  * [Developer environment](https://github.com/gbraad-devenv) image
  * Google Cloud Platform [cloud shell](https://console.cloud.google.com)
  * Windows Subsystem for Linux (WSL2); Bash on Ubuntu on Windows (WSL1)
  * Tested on: CentOS7+, Fedora 21+, and Ubuntu 14.04+
  * GitPod
  * Cygwin64
  * Termux
  * ...


Authors
-------

| [!["Gerard Braad"](http://gravatar.com/avatar/e466994eea3c2a1672564e45aca844d0.png?s=60)](http://gbraad.nl "Gerard Braad <me@gbraad.nl>") |
|---|
| [@gbraad](https://twitter.com/gbraad)  |
