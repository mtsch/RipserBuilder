# RipserBuilder
[![Build Status](https://travis-ci.com/mtsch/RipserBuilder.svg?branch=master)](https://travis-ci.com/mtsch/RipserBuilder)

This repository builds binary artifacts for the [Ripser.jl](https://github.com/mtsch/Ripser.jl)
project. The source code is downloaded from
[ripser.py](https://github.com/scikit-tda/ripser.py). The current build uses ripser.py
version `0.3.0.dev51`.

This repository was created using
[BinaryBuilder.jl](https://github.com/JuliaPackaging/BinaryBuilder.jl).

These builds are not Julia-specific and can be used for other projects as well. They use
Ripser's C interface. See the
[header](https://github.com/scikit-tda/ripser.py/blob/master/ripser/ripser.h) and
[source](https://github.com/scikit-tda/ripser.py/blob/master/ripser/ripser.cpp) files for
more info.
