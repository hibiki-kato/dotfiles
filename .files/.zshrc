#rmを安全化
alias rm='trash'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export "PATH=/usr/local/bin:$PATH"

#githubにdockerからssh接続するための設定
export DOCKER_BUILDKIT=1

#lapackのライブラリ化, リンク作成
export LDFLAGS="-L/opt/homebrew/opt/lapack/lib"
export CPPFLAGS="-I/opt/homebrew/opt/lapack/include"

# OSの名前(自己設定)
export OS_NAME=Darwin

#HomebrewのC/C++コンパイラ指定
export HOMEBREW_CC=gcc
export HOMEBREW_CXX=g++


# Juliaのthread数を指定
export JULIA_NUM_THREADS=8

# Flutterのpath
export PATH="$PATH:/Users/hibiki/Library/CloudStorage/Dropbox/flutter/bin"
