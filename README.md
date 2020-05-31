# emacsd
## Archived
While originally it felt like a great start, this configuration began to feel plagued with issues ranging from mildly annoying, to requiring a force kill of Emacs. My lack of knowledge with Elisp and my ~~need~~ desire to enable every possible thing I might ever want doomed this from early on. It got so bad at one point I swore off Emacs forever, picking up Vim out of spite.

There is still hope in the world, as I have found my way back to Emacs. More specifically, [Doom Emacs](https://github.com/hlissner/doom-emacs). Which I have detailed a bit about in [a blog post](https://ncdulo.github.io/posts/2020/05/doom-emacs-best-of-both-worlds/). I have not felt the need to heavily customize Doom just yet, just a few minor tweaks. For that reason I have not yet placed any of my new configuration into a repository just yet. When I do so, I will very likely just place my `~/.doom.d/` folder into my [dotfiles](https://github.com/ncdulo/dotfiles) as I don't think it really needs a separate repo. That also kind of makes my own maintenance a bit easier. Less things to set up and worry about.

That being said -- *this repository is archived and will not receive any future updates*. It is broken on some levels and is probably not that great. I will keep it online as a reminder of how *not* to configure Emacs. Learn from my mistakes, or just get a good laugh out of this mess.

## Summary
My personal .emacs.d setup. This repository is intended to backup my emacs.d configuration directory while also maintaining a history of changes. The original base was created using [Emacs Bootstrap](http://www.emacs-bootstrap.com/)

## Features
* Automatic installation of required packages via use-package
* Org-mode setup built up around the GTD system
* Delicious zenburn
* Buffer tabs and tab groups
* QoL tweaks to basic editing/movement commands

## TODO
* Org-mode
  * Reimplement notes when switching between certain states
  * Improve tag/category setup
  * Further custom agenda commands
  * Implement habit tracking
  * Implement journal entry and viewing
  * Review notes folder
    * Is there a better way to set it up?
* Backup/Autosave
  * Research into current setup. May need tweaking.
* Buffers
  * Determine why ibuffer shows certain files as "edited" even if they are saved and commited to repo.
* Centaur Tabs
  * Do we need to modify the default tab groups?
* Editing
  * Optimize smartparens setup
    * Might want to enable strict mode
    * I don't like the default C-Right/Left slurp/barf keybinds
  * ~~Determine how to add the colored paren grouping~~

## Project Goals
* Learn ELisp
* Build a modular emacs config
  * And keep it readable too!
* Get the perfect emacs *for me*
