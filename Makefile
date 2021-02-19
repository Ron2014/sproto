.PHONY : all win clean

all : linux
win : sproto.dll

# For Linux
linux:
	make sproto.so "DLLFLAGS = -shared -fPIC"
# For Mac OS
macosx:
	make sproto.so "DLLFLAGS = -bundle -undefined dynamic_lookup"

sproto.so : sproto.c lsproto.c
	env gcc -O2 -Wall $(DLLFLAGS) -o $@ $^

# in mingw you need:
# 
# 1. build & install by source code like
#
# > pacman -S --noconfirm libreadline-devel libreadline
# > make mingw && make install
# cd src && mkdir -p /usr/local/bin /usr/local/include /usr/local/lib /usr/local/man/man1 /usr/local/share/lua/5.3 /usr/local/lib/lua/5.3
# cd src && install -p -m 0755 lua luac /usr/local/bin
# cd src && install -p -m 0644 lua.h luaconf.h lualib.h lauxlib.h lua.hpp /usr/local/include
# cd src && install -p -m 0644 liblua.a /usr/local/lib
# cd doc && install -p -m 0644 lua.1 luac.1 /usr/local/man/man1
#
# 2. build sproto.dll like
#
# > make win
#
sproto.dll : sproto.c lsproto.c
	gcc -O2 -Wall --shared -o $@ $^ -I/usr/local/include -L/usr/local/lib -llua

clean :
	rm -f sproto.so sproto.dll
