alias emacs='emacs -nw'
alias godot='flatpak run org.godotengine.Godot'
alias browsh='sudo docker run -it browsh/browsh'
alias cura='/opt/cura/Cura.AppImage'
alias setup='chmod +x ~/.setup.sh && ~/.setup.sh'

# bash
alias ls='ls --color -la'
alias rm='rm -rf'
alias diff='diff --color'
alias cls='clear'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dir='vdir'
alias vdir='vdir --color'

# git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dfp='/usr/bin/git --git-dir=$HOME/.dotfiles-private --work-tree=$HOME'
alias git-fpd='git fetch --prune && git branch -vv | grep ": gone]" | awk "{print \$1}" | xargs git branch -D'

git_lgbs() {
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    git log --branches --not $(git branch --format "%(refname:short)" | grep -v "$current_branch" | xargs) --pretty="%H" |
    while IFS= read -r hash; do
        git show --color --pretty=format:"%C(bold red)(%h)%Creset %C(bold green)(%ar)%Creset %C(bold blue)<%an>%Creset %C(bold yellow)%s%Creset" $hash
        echo -e "\n"
    done
}

alias git-lgbs='git_lgbs'
alias git-lgb='bash -c '\''current_branch=$(git rev-parse --abbrev-ref HEAD) && git log --oneline --branches --not $(git branch --format "%(refname:short)" | grep -v "^$current_branch$" | xargs) --pretty=format:"%C(red)(%h)%Creset %C(green)(%ar)%Creset %C(blue)<%an>%Creset %s"'\'

# fit
alias g++='g++ -std=c++20 -Wall -pedantic -Wno-long-long'
alias fray='ssh zahraon1@fray1.fit.cvut.cz'

# prusa
alias buildserver='ssh ondra@10.24.42.10'
