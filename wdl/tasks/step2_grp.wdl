version 1.1

task SPAtests {
    input {
        Int chrom
		File exome_bed
		File exome_bim
		File exome_fam
        File model_file
        File variance_ratios
        File GRM
    	File GRM_samples
		File sample_file
		File group_file
		File var_subset
    }

    command <<<
    set -ex
	
    sed 's/ ~{chrom}:/ chr~{chrom}:/g' ~{group_file} > group_file_processed
    cat ~{sample_file} | awk -F " " '{ print $1 }' > sample_file_trim	

    step2_SPAtests.R --bedFile ~{exome_bed} \
                     --bimFile ~{exome_bim} \
                     --famFile ~{exome_fam} \
                     --GMMATmodelFile ~{model_file} \
                     --varianceRatioFile ~{variance_ratios} \
                     --sparseGRMFile ~{GRM} \
                     --sparseGRMSampleIDFile ~{GRM_samples} \
                     --SAIGEOutputFile associations.txt \
                     --LOCO FALSE \
                     --chrom "chr~{chrom}" \
					 --groupFile=group_file_processed \
					 --annotation_in_groupTest damaging_missense,pLoF,synonymous,pLoF:damaging_missense,damaging_missense:pLoF:synonymous 
	#					 --is_Firth_beta TRUE \
	#   					 --pCutoffforFirth=0.05 \
	#					 --is_fastTest=TRUE \

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
        File associations = "associations.txt"
    }
}

