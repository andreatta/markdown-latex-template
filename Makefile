#######################################
# ceerious markdown converter makefile
#######################################

# define template to use for generating PDF
# If it is empty default.latex from pandoc intall is used.
PDFTEMPLATE=templates/plain.latex
PDFDIR=pdf-output/
TEXDIR=tex-output/
MDDIR=

FONT="TeX Gyre Pagella"
# Syntax hiughlighting style can be any of the following: [pygments (this is the default), kate, monochrome, espresso, zenburn, haddock, tango]
STYLE=espresso

# define variables to be used for LATEX
# http://pandoc.org/README#variables-for-latex
LVAR= \
	# most of the variables can be set directly from the markdown file
	#geometry=a4paper

# to future me:
# do not touch unless you are sure what you do.
MDS=$(wildcard $(MDDIR)*.md)
PDFS=$(MDS:$(MDDIR)%.md=$(PDFDIR)%.pdf)
TEX=$(MDS:$(MDDIR)%.md=$(TEXDIR)%.tex)
VARS=$(foreach arg,$(LVAR),--variable $(arg))

all: $(PDFS)
tex: $(TEX)

# multiline function
define convert_md = 
@if [ "$(findstring pdf,$(2))" = "pdf" ]; then \
	echo \*** Creating PDF \***;\
	mkdir -p $(PDFDIR);\
elif [ "$(findstring tex,$(2))" = "tex" ]; then \
	echo \*** Creating TEX \***;\
	mkdir -p $(TEXDIR);\
fi
@echo converting $< to $@ using:
pandoc --standalone --smart --latex-engine=xelatex --template=$(PDFTEMPLATE) $(VARS) --variable mainfont=${FONT} --highlight-style=${STYLE} $(1) -o $(2)
@echo \*** conversion finished \***
endef

# create pdf from every md file in current directory
$(PDFDIR)%.pdf : $(MDDIR)%.md
	$(call convert_md,$<,$@)

$(TEXDIR)%.tex : $(MDDIR)%.md
	$(call convert_md,$<,$@)

# remove generated files if they exist
clean:
	@echo \*** Cleanup previous builds \***
	@$(foreach file,$(PDFS),if [ -f $(file) ]; then rm $(file); fi;)
	@$(foreach file,$(TEX),if [ -f $(file) ]; then rm $(file); fi;)

open:
	@$(foreach file,$(PDFS),if [ -f $(file) ]; then xdg-open $(file); fi;)

rebuild: clean all open

.phony: clean rebuild open tex

