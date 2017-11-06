# set -g -x TERM xterm-256color-italic
set -g -x PATH ~/.composer/vendor/bin $PATH
set -g -x PATH /usr/local/bin $PATH
set -U fish_term24bit
set -U FZF_TMUX 1
set -U FZF_DEFAULT_COMMAND 'pt -g ""'
set -U FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -g theme_color_scheme gruvbox

set -g fish_color_command 458588 --bold
set -g fish_color_param 83a598
set -g fish_color_error cc241d --bold
set -g fish_color_operator 83a598 --bold
