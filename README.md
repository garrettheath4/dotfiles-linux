Linux Personal Profile Dotfiles
===============================

This project contains all of the configuration files I use for all of my
Linux-based logins. When these files are moved to their appropriate places
(where applicable), my standard scripts and settings will be set on that
computer, such as important environment variables, terminal aliases, and
scripts.

Installation
------------
To install this project:

```
git clone https://github.com/garrettheath4/dotfiles-linux.git ~/dotfiles
cd ~/dotfiles
./configure.sh
```

Repository Contents
-------------------

| Repository Item | Description                                                                            | Linking by `configure.sh`                           |
|-----------------|----------------------------------------------------------------------------------------|-----------------------------------------------------|
|`bin/`           | Contains Bash user scripts (mostly convenience scripts)                                |`~/bin` --> `dotfiles-linux/bin/`                    |
|`sbin/`          | Contains Bash administrative scripts (mostly scripts containing `sudo`)                |`~/sbin` --> `dotfiles-linux/sbin/`                  |
|`_.bash_profile` | Contains user Bash settings                                                            |`~/.bash_profile` --> `dotfiles-linux/_.bash_profile`|
|`_.vim/`         | Contains Vim plugins                                                                   |`~/.vim` --> `dotfiles-linux/_.vim/`                 |
|`_.vimrc`        | Contains Vim settings                                                                  |`~/.vimrc` --> `dotfiles-linux/_.vimrc`              |
|`_.gitconfig`    | Contains Git configuration settings                                                    |`~/.gitconfig` --> `dotfiles-linux/_.gitconfig`      |
|`README.md`      | This readme file                                                                       | n/a                                                 |
|`configure.sh`   | A Bash script that creates sym links from the user's home directory to this repository | n/a                                                 |
|`.gitignore`     | Tells Git which files to ignore in this repository if they're changed                  | n/a                                                 |

Future Tasks
------------
 * Merge this repository into [dotfiles-mac](https://github.com/garrettheath4/dotfiles-mac.git "GitHub garrettheath4/dotfiles-mac")

