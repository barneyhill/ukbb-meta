version 1.1

task LDmat {
    input {
		String cohort
        File group_file
        File sample_file
        Int chrom   
		File exome_bed
		File exome_bim
		File exome_fam
    }

    command <<<
    set -ex
        
    cat ~{sample_file} | awk -F " " '{ print $1 }' > sample_file_trim
    sed 's/ ~{chrom}:/ chr~{chrom}:/g' ~{group_file} > group_file_processed

    step3_LDmat.R \
        --bedFile ~{exome_bed} \
        --bimFile ~{exome_bim} \
        --famFile ~{exome_fam} \
        --groupFile group_file_processed \
        --SAIGEOutputFile ~{cohort} \
        --chrom "chr~{chrom}" \
        --sample_include_inLDMat_File=sample_file_trim    

	tar czf LD_mats.tar.gz ~{cohort}_*
    >>>

	runtime{
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
    	dx_instance_type: "mem3_ssd1_v2_x8"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
	    }
		
	}


    output {
    	File info_file = "~{cohort}.marker_info.txt"
	    File LD_mats = "LD_mats.tar.gz"
    }
}


