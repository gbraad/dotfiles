Gerard Braad's dotfiles
=======================

[!["Prompt"](https://raw.githubusercontent.com/gbraad/assets/gh-pages/icons/prompt-icon-64.png)](http://github.com/gbraad)

  using `git`, `stow` and `zsh`


I share it because I got frustrated about moving a tarball around (and
being scared of losing it). This eventually happened when my notebook
got stolen...

These dotfiles are based around a few helpers that deal with settings
up development containers, network functions and connectivity to my
homelab services


  - `dotfiles`  
    handles installation and update of my dotfiles
  - `devenv`  
    deals with development environments
  - `proxy`  
    sets environment to use a proxy to access services
  - `davfs`  
    connects to remote WebDAV endspoints for file sharing
  - `tailscale`  
    aliases and commands for use with my tailnet
  - ...


This forms the basis of my [development environment](https://github.com/gbraad-devenv/) images.


> [!NOTE]
> Do not use this directly, but take parts and learn from it. Treat it as, "what you see is what it is"... 


Installation
------------

### Automated

```
$ git clone https://github.com/gbraad-dotfiles/upstream ~/.dotfiles --recursive
$ ~/.dotfiles/install.sh
```

### Update
After the dotfiles have been installed, it is easy to update using:

```
$ dotup
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
