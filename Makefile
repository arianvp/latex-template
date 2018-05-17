%.ps: %.dot
	dot -Tps $^ -o $@
%.pdf: %.dot
	dot -Tpdf $^ -o $@

.PHONY: FORCE

index.pdf: index.tex FORCE
	latexrun --latex-cmd xelatex --bibtex-cmd biber --latex-args="-shell-escape" $< -o $@

# Such that we can do nix-build for our final thing
.PHONY: install
install: index.pdf
	cp index.pdf ${out}

.PHONY: clean
clean:
	latexrun --clean-all
	rm -rf latex.out



