# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
ENV["BINARYBUILDER_AUTOMATIC_APPLE"] = "true"
using BinaryBuilder

name = "Ripser"
version = v"0.3.2"

# Collection of sources required to build Ripser
sources = [
    "https://github.com/scikit-tda/ripser.py.git" =>
    "b749d0b170f708b9c9b125bffe1c302c870961a2"
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
$CXX -std=c++11 -Ofast -fPIC -shared -L. $LDFLAGS \
     -D USE_COEFFICIENTS -D ASSEMBLE_REDUCTION_MATRIX -D LIBRIPSER \
     ripser.py/ripser/ripser.cpp -o libripser.$dlext
if [[ $dlext == dll ]]; then
    LIB="bin"
else
    LIB="lib"
fi
mkdir $prefix/$LIB
mv libripser.$dlext $prefix/$LIB
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:aarch64, libc=:glibc),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:powerpc64le, libc=:glibc),
    Linux(:i686, libc=:musl),
    Linux(:x86_64, libc=:musl),
    Linux(:aarch64, libc=:musl),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf),
    MacOS(),
    FreeBSD(:x86_64),
    Windows(:i686),
    Windows(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libripser", :libripser)
]

# Dependencies that must be installed before this package can be built
dependencies = [

]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
