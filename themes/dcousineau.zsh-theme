
local user='%{$fg[green]%}%n%{$reset_color%}'
local machine='%{$fg[green]%}%m%{$reset_color%}'
local shortpwd='%{$reset_color%}%1~%{$reset_color%}'
local pwd='%{$fg[cyan]%}%~%{$reset_color%}'
local rvm=''
if which rvm-prompt &> /dev/null; then
  rvm='%{$fg[green]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm='%{$fg[green]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local return_code='%(?..%{$fg[red]%}%?↵ %{$reset_color%})'
local git_branch='%{$reset_color%}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'
local lod='%{$fg[cyan]%}ಠ_ಠ%{$reset_color%}'

local pc=''
if test "$(id -u)" = "0"; then
    pc='%{$fg[yellow]%}»%{$reset_color%}'
    lod='%{$fg[red]%}ಠ_ಠ%{$reset_color%}'
    user='%{$fg[red]%}%n%{$reset_color%}'
else
    pc='%{$reset_color%}»%{$reset_color%}'
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}!"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}×"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}→"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}≡"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}+"

PROMPT="${lod} ${shortpwd}${git_branch} ${pc} "
RPROMPT="${return_code} ${user}%{$fg[green]%}@%{$reset_color%}${machine} ${pwd}"


# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[red]%}detached-head%{$reset_color%})"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}
