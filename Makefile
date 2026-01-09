DATE := $$(date +%Y%m%d)

.DEFAULT_GOAL := cv

.PHONY: devcv
devcv:
	typst watch template/template.typ template/template.pdf --root .

.PHONY: cv
cv:
	typst compile template/template.typ template/my-cv.pdf --root .
