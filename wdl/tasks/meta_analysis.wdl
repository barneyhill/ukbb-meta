version 1.1

task analyse{ 
	input {
		Array[String] cohorts
		Array[File] LD_mats
		Array[File] info_files
		Array[File] associations
		Int num_cohorts = length(cohorts)
	}

	command <<<
	set -ex
	
	mv /Lib_v3.R .
	mv /RV_meta.R .

	for i in ~{sep=" " LD_mats}
	do tar -xzf $i
	for i in 	do tar -xzf $i
	done

	Rscript RV_meta.R \
		--num_cohorts ~{num_cohorts} \
		--chr chr21 \
		--info_file_path ~{sep=" " info_files} \
		--gene_file_prefix ~{sep=" " suffix("_", cohorts)} \
		--gwas_path ~{sep=" " associations} \ 
		--output_prefix associations_output.txt	
	>>>

	runtime {
		docker: "ghcr.io/barneyhill/rare_variant_meta:release"
		dx_instance_type: "mem1_ssd1_v2_x2"
	}

	output {
		File comb_associations = "associations_output.txt"
	}
}


