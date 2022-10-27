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
    }

    command <<<
    set -ex

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
					 --is_fastTest=TRUE \
					 --subSampleFile sample_file_trim \
                     --chrom "chr~{chrom}"
    >>>

	runtime{
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
    	dx_instance_type: "mem2_ssd1_v2_x4"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
	    }
	}

    output {
        File associations = "associations.txt"
    }
}

