version 1.0

task LDmat {
    input {
        File group_file
        File sample_file
        File exome_plink_bed
        File exome_plink_bim
        File exome_plink_fam
    }

    command <<<
    set -ex
    
    cat ~{sample_file} | awk -F " " '{ print $1 }' > sample_file_trim
    sed 's/ 21:/ chr21:/g' ~{group_file} > group_file_processed

    step3_LDmat.R \
        --bedFile ~{exome_plink_bed} \
        --bimFile ~{exome_plink_bim} \
        --famFile ~{exome_plink_fam} \
        --groupFile group_file_processed \
        --SAIGEOutputFile output \
        --chrom chr21 \
        --sample_include_inLDMat_File=sample_file_trim    
    >>>

    runtime {
        docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		dx_instance_type: "mem2_ssd1_v2_x2"
    }

    output {
    	File info_file = "output.marker_info.txt"
	    Array[File] LD_mats = glob("output_*")
    }
}


