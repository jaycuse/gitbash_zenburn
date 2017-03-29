#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

function get_hostname {
  export SHORTNAME=${HOSTNAME}
}

function user_color {
  id | grep "Admin" > /dev/null
  RETVAL=$?
  if [[ $RETVAL == 0 ]]; then
    usercolor="[04;38;5;151m";
  else
    usercolor="[00;38;5;151m";
  fi
}

function settitle() {
  u=${USERNAME}
  h="$u@${HOSTNAME}"
  echo -ne "\e]2;$h\a\e]1;$h\a";
}

# Set directory colors
eval `dircolors ~/.dir_colors`

# Set prompt and window title
inputcolor='[0;37m'
cwdcolor='[01;38;5;223m'
host_name='[01;38;5;174m'
user_color
PROMPT_COMMAND='settitle; get_hostname; history -a;'
export PS1='\n\[\e${cwdcolor}\][$PWD]\n\[\e${usercolor}\][\u]\[\e${host_name}\][${SHORTNAME}]\[\e${inputcolor}\] $ '

# Aliases
alias ls='ls -l --color'
alias grep='grep -n --color'
