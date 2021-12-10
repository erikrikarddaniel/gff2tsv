DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = gunzip -c $@.d/*.tsv.gz > $@.out; if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

all: gff2tsv

gff2tsv: gff2tsv.00

gff2tsv.00:
	../R/gff2tsv.R $@.d/*.gff.gz
	@$(CHECK)
