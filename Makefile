all: data/STJ2015_sym.RData

data/STJ2015_sym.RData: data/STJ2015.RData
	R --vanilla < ~/SymITS2/filter_notsym.R --args data/STJ2015.RData data/clust/all_rep_set_rep_set.fasta data/STJ2015_sym.RData /Volumes/CoralReefFutures/ref/ncbi_nt/nt

data/STJ2015.RData: data/clust/all_rep_set_rep_set_nw_tophits.tsv data/mapping_file.txt
	R --vanilla < ~/SymITS2/build_phyloseq.R --args $^ data/clust/97_otus_bysample.tsv data/ITS2db_trimmed_notuniques_otus.txt data/STJ2015.RData

data/clust/all_rep_set_rep_set_nw_tophits.tsv: data/clust/all_rep_set_rep_set.fasta data/ITS2db_trimmed_derep.fasta
	R --vanilla < ~/SymITS2/run_nw.R --args $^

data/clust/all_rep_set_rep_set.fasta: data/fasta/combined_seqs_trimmed.fasta 
	bash ~/SymITS2/otus_97_bysample.sh $< data/clust
	
data/fasta/combined_seqs_trimmed.fasta: data/merge
	bash ~/SymITS2/qc_trim_reads.sh

data/merge: data/fastq_list.txt
	bash ~/SymITS2/merge_reads.sh
