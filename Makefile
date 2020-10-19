## This is nCoV_framework, led by Sang Woo Park
## makestuff/project.Makefile

current: target
-include target.mk

# include makestuff/perl.def

######################################################################

# Content

Sources += $(wildcard *.R)

vim_session:
	bash -cl "vmt"

Sources += $(wildcard *.tex)
Ignore += ncov.pdf
ncov.pdf: ncov.tex

compare_R0.pdf: compare_R0.Rout ;
compare_R0.Rout: compare_R0.R
	Rscript $< > $@

Ignore += compare_R0.jpg compare_R0.png
compare_R0.%g: compare_R0.pdf
	$(convert)

Ignore += compare_assumption.jpg
compare_assumption.jpg: compare_assumption.pdf
	convert -density 300 $< $@

Ignore += assumption_*.jpg
assumption_1.jpg: compare_assumption.jpg
	convert -crop 1000x900+0+0 $< $@

assumption_2.jpg: compare_assumption.jpg
	convert -crop 1000x900+1000+0 $< $@

assumption_3.jpg: compare_assumption.jpg
	convert -crop 1000x900+2000+0 $< $@

Ignore += figure2.jpg
figure2.jpg: figure2.pdf
	convert -density 300 $< $@

# propagate_pix.pdf: propagate_pix.R
Ignore += propagate_pix-*.*
propagate_pix.tex: propagate_pix.Rout ;
propagate_pix.Rout: figure2.Rout propagate_pix.R

## Revision

Ignore += response.pdf
response.pdf: response.tex
	pdflatex $<

######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk

## Adding wrapR for now … 2020 Feb 06 (Thu)
## -include makestuff/wrapR.mk
-include makestuff/texdeps.mk
-include makestuff/wrapR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
