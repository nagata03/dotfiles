#########################################
### プロンプトにGitのブランチ名を表示 ###
#########################################
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

########################
### エイリアスの設定 ###
########################
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -la'
alias brew="env PATH=${PATH/\/Library\/Frameworks\/Python\.framework\/Versions\/3\.6\/bin:/} brew"

########################
### pecoに関する設定 ###
########################
HISTTIMEFORMAT='%Y.%m.%d %T' # historyに時間を追加

peco-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-history'

ghql() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      cd ${selected_file}
      echo "Current Directory: `pwd`"
    fi
  fi
}
bind -x '"\C-g": ghql'

##############################
### 出力の後に改行を入れる ###
##############################
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'

########################
### プロンプトの設定 ###
########################
PS1='\[\e[36m\][\u:\h \w]\[\e[m\]\[\e[1;31m\]$(__git_ps1)\[\e[m\]\n \[\e[33m\]\t \[\e[1;36m\]\$ \[\e[m\]'
if [[ -n "${VIMRUNTIME}" ]]; then
	PS1='\[\e[36m\][\u:\h \w]\[\e[m\]\[\e[1;31m\]$(__git_ps1)\[\e[m\]\n \[\e[33m\]\t \[\e[32m\](VIM*)\[\e[1;36m\]\$ \[\e[m\]'
fi

