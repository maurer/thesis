.PHONY: FORCE, clean
%.pdf: FORCE
	latexmk $* -pdf
FORCE:

clean:
	rm -f *.pdf *.toc *.log *.fls *.aux *.fdb_latexmk *.out
