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

all: ths.pdf toc.pdf

ths.ps: ths.ms ths.tmac
	@echo "Indexing labels in ths.ms"
	@cat $< | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) -rths.idx=1 -meps -mtbl -mkeep -mfa -msrefs 2>&1 1>/dev/null | \
		tee .ths.err | sed '/^\./d'
	@sed '/^\./p; d' <.ths.err >.ths.tr
	@echo "Generating ths.ps"
	@cat $< | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) -meps -mtbl -mkeep -mfa -msrefs | $(POST) -pa4 >$@

toc.ps: toc.ms ths.ps
	@echo "Generating toc.ps"
	@cat toc.ms | $(SOIN) | $(SHAPE) | \
		$(REFER) -m -e -o ct -p ref.bib | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) -meps -mtbl -mkeep -mfa -msrefs | $(POST) -pa4 >$@

%.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -sFONTPATH=$(BASE)/fonts/ $< $@

clean:
	rm -f *.ps *.pdf
