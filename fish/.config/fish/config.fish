# set -g -x TERM xterm-256color-italic
set -g -x PATH ~/.composer/vendor/bin $PATH
set -U fish_term24bit
set -U FZF_TMUX 1
set -U FZF_DEFAULT_COMMAND 'pt -g ""'
set -U FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
