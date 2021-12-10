DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = gunzip -c $@.d/*.tsv.gz > $@.out; if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

all: clean gff2tsv

clean:
	rm gff2tsv.*.d/*.tsv.gz

gff2tsv: gff2tsv.00 gff2tsv.01

gff2tsv.00:
	@../R/gff2tsv.R --verbose $@.d/*.gff.gz
	@$(CHECK)

gff2tsv.01:
	@../R/gff2tsv.R --singlefile $@.d/$@.tsv.gz $@.d/*.gff.gz
	@$(CHECK)
