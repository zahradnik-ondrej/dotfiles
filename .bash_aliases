alias godot='flatpak run org.godotengine.Godot'
alias browsh='sudo docker run -it browsh/browsh'
alias cura='/opt/cura/Cura.AppImage'
alias setup='chmod +x ~/.setup.sh && ~/.setup.sh'
alias etcher='/opt/balenaEtcher/balenaEtcher.AppImage'

# test.sh
test_sh() {

	if [ -d ~/test.sh ] && [ -f ~/test.sh/test.sh ]; then
		bash ~/test.sh/test.sh "$@";
	else
		git clone https://github.com/zahradnik-ondrej/test.sh.git ~/test.sh;
		bash ~/test.sh/test.sh "$@";
	fi

}

alias testsh='test_sh'

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
alias grep='grep -rIn --color=always --exclude-dir=venv'

# git
git_bl() {
	git blame "$@"
}

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dfp='/usr/bin/git --git-dir=$HOME/.dotfiles-private --work-tree=$HOME'
alias git-fpd='git fetch --prune && git branch -vv | grep ": gone]" | awk "{print \$1}" | xargs git branch -D'
alias git-add100='find . -type f -size -100M -print0 | xargs -0 git add'
alias git-bl=git_bl

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
alias bs='ssh ondra@10.24.42.10'
alias usbsdmux='/usr/bin/usbsdmux'
alias ctrl='(cwd=$(pwd) && cd /home/ondra/prusa/meta-sl1-hw-tests/ && python3 tools/control.py && cd "$cwd")'

