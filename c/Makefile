CC := gcc
RM := rm
CD := cd
MAKE := make
LDFLAGS := -shared

CFLAGS += -Wall -Wextra -fpic -O3 -fno-strict-aliasing -Wno-unused-parameter

SYS := $(shell gcc -dumpmachine)

ifneq (, $(findstring linux, $(SYS)))
	SUFFIX := so
else ifneq (, $(findstring mingw, $(SYS)))
	SUFFIX := dll
else 
	$(error Unsupported build platform)
endif

ifndef GLOBALS_HOME
     $(error Couldn't find GLOBALS_HOME)
endif

INCLUDES += -I${GLOBALS_HOME}/dev/cpp/include
CFLAGS += $(INCLUDES)

.PHONY: all clean

all: iscsetenv.$(SUFFIX)

iscpython.o: iscsetenv.c

iscsetenv.$(SUFFIX): iscsetenv.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

clean:
	$(RM) *.$(SUFFIX) *.o