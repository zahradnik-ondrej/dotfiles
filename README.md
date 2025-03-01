<div align="center">

# 💠 dotfiles [^1]  

### A better way to manage your dotfiles *(or any other non directory-specific files [^2])*.

You will never have to put all your dotfiles into one folder or use symlinks ever again.

*(The instructions below have been made to work on **Linux** operating systems, specifically on **Ubuntu 22.04** along with the prerequisite of having **Git** installed on your system.)*

</div>

***

### Create a new dotfiles repository:
1. `mkdir $HOME/.dotfiles`  
2. `git init --bare $HOME/.dotfiles`  
3. `echo "alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`  
4. `bash`  
5. `dots config --local status.showUntrackedFiles no`  
6. create a new repository on GitHub *(or any other Git server hosting service)* but do **NOT** include a `README.md` or any other files such as a license  
7. `dots remote add origin https://github.com/<username>/<repository_name>.git`  

***

### Add / update a dotfile:
1. `dots add <file/directory_name>`  
2. `dots commit -m "Add/Update <file/directory_name(s)>"`  
3. `dots push` [^3]

### Update all dotfiles:
1. `dots add -u`
2. `dots commit -m "Update all files"`  
3. `dots push` [^3]

### Remove a dotfile:
1. `dots rm <file_name>` or `dotfiles rm -r <directory_name>` 
2. `dots commit -m "Remove <file/directory_name(s)>"`  
3. `dots push` [^3]

***

### Update the local repository:
* `dots pull`

***

### Clone *(download)* a dotfiles repository:
1. `echo "alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`  
2. `echo '.dotfiles' >> .gitignore`  
3a. `git clone --bare https://github.com/<username>/<repository_name>.git $HOME/.dotfiles` *(general dotfiles repository)*  
3b. `git clone --bare https://github.com/zahradnik-ondrej/dotfiles.git $HOME/.dotfiles` *(this dotfiles repository)*
4. `bash`
5. `dots checkout -f`  
6. `dots config --local status.showUntrackedFiles no`
7. `bash`

[^1]: Inspired by a YouTube video from [DistroTube](https://www.youtube.com/@DistroTube) - [Git Bare Repository - A Better Way To Manage Dotfiles](https://www.youtube.com/watch?v=tBoLDpTWVOM&ab_channel=DistroTube) and a blog post by [Nicola Paolucci](https://twitter.com/durdn) - [Dotfiles: Best Way to Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles).

[^2]: While this approach mainly serves as a better way to manage dotfiles, there is nothing special about it so that it couldn't be used for other types of files. That means you could use this approach for backing up any kind of data such as documents *(Word, PDF, etc.)*, media files *(pictures, videos, music)* or software, especially if you are hosting your own Git server or paying for one *(that's mainly due to storage, security and privacy concerns when it comes to backing up your data this way)*.
