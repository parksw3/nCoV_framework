## This is wuhan, Daniel's nCoV directory
## makestuff/project.Makefile

current: target
-include target.mk

# include makestuff/perl.def

######################################################################

# Content

Sources += $(wildcard *.R) cover.md

vim_session:
	bash -cl "vmt"

Sources += ncov.tex 
ncov.pdf: compare_R0.pdf ncov.tex

compare_R0.pdf: compare_R0.Rout ;
compare_R0.Rout: compare_R0.R
	Rscript $< > $@

Ignore += compare_R0.jpg compare_R0.png
compare_R0.%g: compare_R0.pdf
	$(convert)

Ignore += compare_assumption.jpg
compare_assumption.jpg: compare_assumption.pdf Makefile
	convert -density 300 $< $@

Ignore += assumption_*.jpg
assumption_1.jpg: compare_assumption.jpg
	convert -crop 1000x900+0+0 $< $@

assumption_2.jpg: compare_assumption.jpg
	convert -crop 1000x900+1000+0 $< $@

assumption_3.jpg: compare_assumption.jpg
	convert -crop 1000x900+2000+0 $< $@

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
