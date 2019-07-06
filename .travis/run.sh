set -e
set -x 

if [[ "$(uname -s)" == 'Darwin' ]]; then
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi
    pyenv activate conan
    export CXX=clang++-$CONAN_APPLE_CLANG_VERSIONS
    export CC=clang-$CONAN_APPLE_CLANG_VERSIONS

    conan create . LunarWatcher/testing --build missing
else 

    if [ $CONAN_CLANG_VERSIONS ]; then
        export CXX=clang++-$CONAN_CLANG_VERSIONS
        export CC=clang-$CONAN_CLANG_VERSIONS
    else 
        export CXX=g++-$CONAN_GCC_VERSIONS
        export CXX=gcc-$CONAN_GCC_VERSIONS
    fi

    docker run -d -p 127.0.0.1:80:4567 -v .:/conan-IXWebSocket $CONAN_DOCKER_IMAGE "cd conan-IXWebSocket; conan create . LunarWatcher/testing --build missing"
fi


