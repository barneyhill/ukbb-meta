version 1.0

task analyse{ 
	input {
		Array[String] cohorts
		Array[Array[File]] LD_mats
		Array[File] info_files
		Array[File] associations
		File associations_output = "associations_output.txt"
		Int num_cohorts = length(cohorts)
	}

	command <<<
	set -ex
	
	cohort_i = 0
	COHORTS=(~{sep=" " cohorts})""})
	while read line; do
		mv $line COHORTS[$cohort_i]/
		COUNT=$(( $COUNT + 1 ))
	done < ~{write_tsv(LD_mats)})})}

	Rscript RV_meta.R \
		--num_cohorts 2 \
		--chr 7 \
		--info_file_path ~{sep=" " info_files} \
		--gene_file_prefix ~{sep="/ " cohorts} \
		--gwas_path ~{sep=" " associations} \ 
		--output_prefix ~{associations_output} | tee test_log.out
	cat test_log.out 
	>>>

	runtime {
		docker: "ghcr.io/barneyhill/rare_variant_meta:release"
		dx_instance_type: "mem2_ssd1_v2_x16"
	}

	output {
		File comb_associations = associations_output
	}
}


