all: thesis.pdf

.PHONY: FORCE, clean, all

cfg.pdf: cfg.dot
	dot -Tpdf cfg.dot > cfg.pdf

%.pdf: FORCE cfg.pdf
	latexmk -f $* -pdf
FORCE:

clean:
	rm -f *.synctex.gz *.blg *.bbl *.brg *.brf *.pdf *.toc *.log *.fls *.aux *.fdb_latexmk *.out */*.aux
