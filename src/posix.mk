# common POSIX parts. Makefile.{Linux,OpenBSD,FreeBSD,NetBSD,Darwin} all inherit from this
# the values in here correspond to the

# --- config ---

ifndef OBJEXT
  OBJEXT:=o
endif
  
# extend the list of $(CC), $(YACC), ... with extra standard programs variables
# so that we can tolerate the POSIX incompatible parts of Windows by override.
ifndef LN #XXX assuming that this missing means all are missing
WHICH:=which
NULL:=/dev/null
MV:=mv
CAT:=cat
RM:=rm -f
RMDIR:=rm -rf
CP:=cp
MKDIR:=mkdir -p
LN:=ln -f
endif

ifndef DLLEXT #hack: this guards against overwriting DLLEXT:=dll in the MinGW path
  DLLEXT:=so
endif

CFLAGS+=-Wall -Werror

# strange, make comes with .LIBPATTERNS yet doesn't come with rules for actually making .so files
%.$(DLLEXT):
	$(CC) $(LDFLAGS) $^  -o $@  $(foreach L,$(LIBS),-l$L)


#svm.plugin: $(OS)/$(ARCH)/svm.plugin

# --- testing ---


# --- cleaning ---

.PHONY: clean-posix
clean-posix:
	-$(RM) *.so


clean: clean-posix
