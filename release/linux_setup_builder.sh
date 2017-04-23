#!/bin/sh

# This script depends on the GNU script makeself.sh found at: http://megastep.org/makeself/
# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.0.0"
arch=`uname -i`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
    QtLIBPATH="${HOME}/Qt/5.4/gcc_64"
else
    arch="32bit"
    QtLIBPATH="${HOME}/Qt/5.4/gcc"
fi

if [ -f verium-qt ] && [ -f verium.conf ] && [ -f README ]; then
    echo "Building Verium_${version}_${arch}.run ...\n"
    if [ -d Verium_${version}_${arch} ]; then
        rm -fr Verium_${version}_${arch}/
    fi
    mkdir Verium_${version}_${arch}
    mkdir Verium_${version}_${arch}/libs
    mkdir Verium_${version}_${arch}/platforms
    mkdir Verium_${version}_${arch}/imageformats
    cp verium-qt Verium_${version}_${arch}/
    cp verium.conf Verium_${version}_${arch}/
    cp README Verium_${version}_${arch}/
    ldd verium-qt | grep libssl | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libdb_cxx | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libboost_system | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libboost_filesystem | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libboost_program_options | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libboost_thread | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libminiupnpc | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    ldd verium-qt | grep libqrencode | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} Verium_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libQt*.so.5 Verium_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libicu*.so.53 Verium_${version}_${arch}/libs/
    cp ${QtLIBPATH}/plugins/platforms/lib*.so Verium_${version}_${arch}/platforms/
    cp ${QtLIBPATH}/plugins/imageformats/lib*.so Verium_${version}_${arch}/imageformats/
    strip Verium_${version}_${arch}/verium-qt
    echo "Enter your sudo password to change the ownership of the archive: "
    sudo chown -R nobody:nogroup Verium_${version}_${arch}

    # now build the archive
    if [ -f Verium_${version}_${arch}.run ]; then
        rm -f Verium_${version}_${arch}.run
    fi
    makeself.sh --notemp Verium_${version}_${arch} Verium_${version}_${arch}.run "\nCopyright (c) 2014-2015 The Verium Developers\nVerium will start when the installation is complete...\n" ./verium-qt \&
    sudo rm -fr Verium_${version}_${arch}/
    echo "Package created in: $PWD/Verium_${version}_${arch}.run\n"
else
    echo "Error: Missing files!\n"
    echo "Copy this file to a setup folder along with verium-qt, verium.conf and README.\n"
fi

