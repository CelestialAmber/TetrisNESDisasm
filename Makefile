WINDOWS := $(shell which wine ; echo $$?)
UNAME_S := $(shell uname -s)

tetris_obj := tetris-ram.o tetris.o
cc65Path := cc65

# Hack for OSX
ifeq ($(UNAME_S),Darwin)
	SHA1SUM := shasum
else
	SHA1SUM := sha1sum
endif

CA65 := $(cc65Path)/bin/ca65
LD65 := $(cc65Path)/bin/ld65
nesChrEncode := python3 tools/nes-util/nes_chr_encode.py

tetris.nes: tetris.o tetris-ram.o

tetris:= tetris.nes

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: clean compare tools


CAFLAGS = -g
LDFLAGS =

compare: $(tetris)
	$(SHA1SUM) -c tetris.sha1

clean:
	rm -f  $(tetris_obj) $(tetris) *.d tetris.dbg tetris.lbl gfx/*.chr
	$(MAKE) clean -C tools/cTools/
	$(MAKE) clean -C cc65/

$(CA65): cc65/src/ca65/*.c
	$(MAKE) ca65 -C cc65/

$(LD65): cc65/src/ld65/*.c
	$(MAKE) ld65 -C cc65/

tools:
	$(MAKE) -C tools/cTools/


# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tools/cTools/,$(MAKECMDGOALS)))
$(info $(shell $(MAKE) -C tools/cTools/))
endif

%.o: dep = $(shell tools/cTools/scan_includes $(@D)/$*.asm)
$(tetris_obj): %.o: %.asm $$(dep) $(CA65) $(LD65)
		$(CA65) $(CAFLAGS) $*.asm -o $@

%: %.cfg
		$(LD65) $(LDFLAGS) -Ln $(basename $@).lbl --dbgfile $(basename $@).dbg -o $@ -C $< $(tetris_obj)



%.chr: %.png
		$(nesChrEncode) $< $@


