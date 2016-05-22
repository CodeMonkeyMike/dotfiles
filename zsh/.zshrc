# Folder for user made ZSH functions
fpath=("$HOME/.zfunctions" $fpath)

# Load functions for pure prompt
autoload -U promptinit && promptinit

# The max execution time of a process before its run time is shown when it exits. Defaults to 5 seconds
# PURE_CMD_MAX_EXEC_TIME=5

# Set PURE_GIT_PULL=0 to prevent Pure from checking whether the current Git remote has been updated.
# PURE_GIT_PULL=0

# Set PURE_GIT_UNTRACKED_DIRTY=0 to not include untracked files in dirtiness check. Only really useful on extremely huge repos like the WebKit repo.
# PURE_GIT_UNTRACKED_DIRTY=0

# Time in seconds to delay git dirty checking for large repositories (git status takes > 2 seconds). The check is performed asynchronously, this is to save CPU. Defaults to 1800 seconds.
# PURE_GIT_DELAY_DIRTY_CHECK=1800

# Defines the prompt symbol. The default value is ❯.
# PURE_PROMPT_SYMBOL=❯

# Defines the git down arrow symbol. The default value is ⇣.
# PURE_GIT_DOWN_ARROW=⇣

# Defines the git up arrow symbol. The default value is ⇡.
# PURE_GIT_UP_ARROW=⇡

# Load pure prompt
prompt pure
