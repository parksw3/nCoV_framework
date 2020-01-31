## This is wuhan, Daniel's nCoV directory
## makestuff/project.Makefile

current: target
-include target.mk

# include makestuff/perl.def

######################################################################

# Content

vim_session:
	bash -cl "vmt"

Sources += ncov.tex
ncov.pdf: ncov.tex compare_R0.Rout

compare_R0.Rout: compare_R0.R
	Rscript compare_R0.R >compare_R0.Rout

compare_R0.jpg: compare_R0.pdf
	$(convert)

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

## -include makestuff/wrapR.mk
-include makestuff/texdeps.mk

-include makestuff/git.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
