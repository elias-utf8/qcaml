.PHONY: test coverage clean build doc

build:
	dune clean
	dune build

test:
	dune runtest --instrument-with bisect_ppx --force

coverage: test
	bisect-ppx-report html
	@echo "Coverage report generated in _coverage/index.html"

coverage-summary: test
	bisect-ppx-report summary --per-file

clean:
	dune clean
	rm -f bisect*.coverage
	rm -rf _coverage

open-coverage: coverage
	xdg-open _coverage/index.html || open _coverage/index.html

doc:
	dune build @doc
