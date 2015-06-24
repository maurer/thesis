all: proposal.pdf

.PHONY: FORCE, clean, all
%.pdf: FORCE
	latexmk $* -pdf
FORCE:

clean:
	rm -f *.blg *.bbl *.brg *.brf *.pdf *.toc *.log *.fls *.aux *.fdb_latexmk *.out
