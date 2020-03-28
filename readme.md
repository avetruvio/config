# Installing Dotfiles

## TL;DR

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME '
dotfiles clone --bare https://gitlab.com/k4tsh/dotfiles.git ~/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

After this, just use `dotfiles pull` to keep up to date. 

This readme will be installed to your `$HOME/readme.md`
You can delete this readme after running `dotfiles update-index --assume-unchanged ~/readme.md` to prevent it coming back on a `dotfiles pull`

If you've forked the repo for yourself, you can use `dotfiles commit` and `dotfiles push` just like you would a regular git repo. 

## Explained: 

We'll be using a git bare repository, which will be able to track our changes and do version control between multiple machines, however the special part is the "bare" in "git bare repository". What this means, is that rather than keeping all repository files in the same directory, the repository can track files anywhere within the home directory. 

### 1. The Alias

The alias defined shortens the command line options for our git bare repository into a single command, `dotfiles`. This can be called from anywhere in the `$HOME` directory to add, remove, or update configuration files. 

We define this alias before installing just to make the first few commands that much easier until our configuration files are installed. Our dotfiles also define this alias, but since we don't have them yet, we manually define it here. 

### 2. `dotfiles clone`

This is basically just a standard clone, replacing `git` with our `dotfiles` alias, and being sure to tell it to put the git repository's configuration files into the `.dotfiles` folder. 

### 3. `dotfiles checkout`

Cloning our git bare repository does not yet put all our dotfiles into the right place. So far, all our dotfiles are locked up in the .dotfiles directory as git-specific files used for tracking changes. To put the real dotfiles out on the system, we've got to do our `dotfiles checkout` command which will put all the files in the right place. 

One caveat though - if this command would overwrite any preexisting configuration files on your machine, the command will halt and notify you where these possible conflicts reside. To continue using my dotfiles, it is required to remove (or at least move out of the way) the existing configuration files to let `dotfiles checkout` put everything in the right place. 

### 4. `dotfiles config`

A housekeeping command to make things easier, is `dotfiles config --local status.showUntrackedFiles no`. This prevents git from auto-suggesting you track every file in your home directory every time you try `dotfiles status`. 
