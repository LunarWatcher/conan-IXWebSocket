set -e
set -x 

if [[ "$(uname -s)" == 'Darwin' ]]; then
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi
    pyenv activate conan
    export CONAN_OPTIONS="IXWebSocket:use_mbed_tls=True"
fi

python build.py
