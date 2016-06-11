dotfiles
========

Do not use this directly, but take parts and learn from it. I share it because
I got frustrated about moving a tarball around (and being scared of loosing
it). Which eventually happened when my notebook got stolen... so, this is not
an ideal solution yet. It only contains the basic from an old tarball, and still
needs all the customization for vim, emacs, etc. No install script, no comments,
nothing... for now, "what you see is what it is"...


Requirements
------------

CentOS/Fedora
```
$ yum install tmux zsh mc stow #dnf
```

Debian/Ubuntu
```
$ apt-get install tmux zsh mc stow
```

After this you can use GNU `stow` to install the dotfiles per application

```
$ git clone https://github.com/gbraad/dotfiles.git .dotfiles
$ cd .dotfiles
$ git submodule init
$ git submodule update
$ stow zsh
```



Authors
-------

| [!["Gerard Braad"](http://gravatar.com/avatar/e466994eea3c2a1672564e45aca844d0.png?s=60)](http://gbraad.nl "Gerard Braad <me@gbraad.nl>") |
|---|
| [@gbraad](https://twitter.com/gbraad)  |
