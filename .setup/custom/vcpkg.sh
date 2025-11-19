if [ ! -d $HOME/.local/share/vcpkg ]; then
    cd $HOME/.local/share/
    git clone https://github.com/microsoft/vcpkg.git
    cd vcpkg
    ./bootstrap-vcpkg.sh
fi
