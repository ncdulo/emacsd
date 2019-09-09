# emacsd
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
