set -e
set -x 


if [[ "$(uname -s)" == 'Darwin' ]]; then
    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi
    pyenv activate conan
    export CXX=clang++
    export CC=clang
    export IX_OPTIONS="-o IXWebSocket:use_mbed_tls=True"
    
    conan profile new --detect default
    ./.travis/shared.sh    
else 

    if [ $CONAN_CLANG_VERSIONS ]; then
        export CXX=clang++-$CONAN_CLANG_VERSIONS
        export CC=clang-$CONAN_CLANG_VERSIONS
    else 
        export CXX=g++-$CONAN_GCC_VERSIONS
        export CXX=gcc-$CONAN_GCC_VERSIONS
    fi

    docker run -v $PWD:/conan-IXWebSocket $CONAN_DOCKER_IMAGE /bin/bash -c "cd /conan-IXWebSocket; \
conan profile new --detect default; \
conan profile update settings.compiler.libcxx=libstdc++11 default; \
CONAN_PASSWORD=$CONAN_PASSWORD
./.travis/shared.sh"
fi


