# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
ENV["BINARYBUILDER_AUTOMATIC_APPLE"] = "true"
using BinaryBuilder

name = "Ripser"
version = v"0.3.0"

# Collection of sources required to build Ripser
sources = [
    "https://github.com/scikit-tda/ripser.py.git" =>
    "58cd3e4be67a1f2fa3c297f7f00f217e4ce66974",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
if [[ $(uname) == MSYS* ]]; then
    EXT="dll"
elif [[ $(uname) == "Darwin" ]]; then
    EXT="dylib"
else
    EXT="so"
fi
$CXX -std=c++11 -Ofast -fPIC -shared -L. -D NDEBUG -D USE_COEFFICIENTS -D ASSEMBLE_REDUCTION_MATRIX -D LIBRIPSER ripser.py/ripser/ripser.cpp -o libripser.$EXT
mkdir $prefix/lib
mv libripser.$EXT $prefix/lib
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
    BinaryProvider.MacOS(),
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
