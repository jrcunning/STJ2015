data/STJ2015.Rdata: data/otus_97_bysample/nw_tophits.tsv data/otus_97_bysample/97_otus_bysample.tsv data/mapping_file.txt
	R --vanilla < ~/SymITS2/build_phyloseq.R --args data/otus_97_bysample/nw_tophits.tsv data/mapping_file.txt data/otus_97_bysample/97_otus_bysample.tsv STJ2015

data/otus_97_bysample/nw_tophits.tsv: data/otus_97_bysample/all_rep_set_rep_set.fasta data/ITS2db_trimmed_derep.fasta
	R --vanilla < ~/SymITS2/run_nw.R --args $< data/ITS2db_trimmed_derep.fasta

data/otus_97_bysample/97_otus_bysample.tsv: data/fasta/combined_seqs_trimmed.fasta
	bash ~/SymITS2/otus_97_bysample.sh

data/fasta/combined_seqs_trimmed.fasta: data/merge
	bash ~/SymITS2/qc_trim_reads.sh

data/merge: data/fastq_list.txt
	bash ~/SymITS2/merge_reads.sh
