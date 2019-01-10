ifeq ($(platform), Windows)
	EXT := .dll
else
	EXT := .so
endif

libripser: ripser.cpp
	c++ -std=c++11 -Ofast -fPIC -shared -L. -D NDEBUG -D USE_COEFFICIENTS -D ASSEMBLE_REDUCTION_MATRIX -D LIBRIPSER ripser.cpp -o libripser$(EXT)
