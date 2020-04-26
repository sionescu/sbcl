include sbcl.mk

all: targets
BINARIES=sbcl sbcl.extras
targets: $(BINARIES)

LIBFIXPOSIX=/usr/local/lib64/libfixposix.a
LIBCRYPTO=/home/hechee/work/rpmbuild/BUILD/openssl-1.1.1g/libcrypto.a
LIBSSL=/home/hechee/work/rpmbuild/BUILD/openssl-1.1.1g/libssl.a
STATIC_ARCHIVES=$(LIBFIXPOSIX) $(LIBCRYPTO) $(LIBSSL)
SLIBS=-Wl,--whole-archive $(STATIC_ARCHIVES) -Wl,--no-whole-archive

sbcl: $(LIBSBCL)
	$(CC) -fno-pie -no-pie $(LINKFLAGS) -o $@ $(LIBSBCL) $(LIBS)

sbcl.extras: $(LIBSBCL)
	$(CC) -fno-pie -no-pie $(LINKFLAGS) -o $@ $(LIBSBCL) $(SLIBS) $(LIBS)

clean:
	$(RM) $(BINARIES)

.PHONY: all targets
