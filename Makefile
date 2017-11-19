# BASE should point to neatroff_make/
BASE = $(PWD)/..
ROFF = $(BASE)/neatroff/roff
POST = $(BASE)/neatpost/post
EQN = $(BASE)/neateqn/eqn
REFER = $(BASE)/neatrefer/refer
PIC = $(BASE)/troff/pic/pic
TBL = $(BASE)/troff/tbl/tbl
SOIN = $(BASE)/soin/soin
JOIN = $(BASE)/roffjoin/roffjoin
SHAPE = $(BASE)/shape/shape

ROFFOPTS = -mps -meps -mtbl -mkeep -mfa -msrefs
POSTOPTS = -p1700x2450

all: ths.pdf fm.pdf bm.pdf

ths.ps: ths.ms ths.tmac
	@echo "Indexing labels in ths.ms"
	@cat $< | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) -rths.idx=1 $(ROFFOPTS) 2>&1 1>/dev/null | \
		tee .ths.err | sed '/^\./d'
	@sed '/^\./p; d' <.ths.err >.ths.tr
	@echo "Generating ths.ps"
	@cat $< | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

fm.ps: fm.ms ths.ps
	@echo "Generating fm.ps"
	@cat fm.ms | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

bm.ps: bm.ms ths.tmac
	@echo "Generating bm.ps"
	@cat bm.ms | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

%.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -sFONTPATH=$(BASE)/fonts/ $< $@

clean:
	rm -f *.ps *.pdf
