# BASE should point to neatroff_make/
BASE = $(PWD)/..
ROFF = $(BASE)/neatroff/roff
POST = $(BASE)/neatpost/post
EQN = $(BASE)/neateqn/eqn
REFR = $(BASE)/neatrefer/refer
PIC = $(BASE)/troff/pic/pic
TBL = $(BASE)/troff/tbl/tbl
SOIN = $(BASE)/soin/soin
JOIN = $(BASE)/roffjoin/roffjoin
SHAPE = $(BASE)/shape/shape

ROFFOPTS = -mps -meps -mtbl -mkeep -mfa
POSTOPTS = -p1700x2450
REFROPTS = -e -a ct,ctfa -sa -p ths.bib

all: all.pdf

ths.ps: ths.ms ths.tmac ths.bib
	@echo "Indexing labels in ths.ms"
	@cat $< | $(SOIN) | $(REFR) $(REFROPTS) | \
		$(SHAPE) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) -rths.idx=1 $(ROFFOPTS) 1>/dev/null
	@echo "Generating ths.ps"
	@cat $< | $(SOIN) | $(REFR) $(REFROPTS) | \
		$(SHAPE) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

fm.ps: fm.ms ths.ps
	@echo "Generating fm.ps"
	@cat fm.ms | $(SOIN) | $(REFR) $(REFROPTS) | \
		$(SHAPE) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

bm.ps: bm.ms ths.tmac
	@echo "Generating bm.ps"
	@cat bm.ms | $(SOIN) | $(REFR) $(REFROPTS) | \
		$(SHAPE) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

all.ps: ths.ps fm.ps
	@echo "Generating all.ps"
	@(cat fm.ms ths.ms bm.ms) | $(SOIN) | $(REFR) $(REFROPTS) | \
		$(SHAPE) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) -rths.all=1 | $(POST) $(POSTOPTS) >$@

%.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -sFONTPATH=$(BASE)/fonts/ $< $@

clean:
	rm -f *.ps *.pdf
