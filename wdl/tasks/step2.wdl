version 1.1

task SPAtests {
    input {
        File group_file
        File exome_plink_bed
        File exome_plink_bim
        File exome_plink_fam
        File model_file
        File variance_ratios
        File GRM
    	File GRM_samples
    }

    command <<<
    set -ex
    
    sed 's/ 21:/ chr21:/g' ~{group_file} > group_file_processed

    step2_SPAtests.R --bedFile ~{exome_plink_bed} \
                     --bimFile ~{exome_plink_bim} \
                     --famFile ~{exome_plink_fam} \
                     --GMMATmodelFile ~{model_file} \
                     --varianceRatioFile ~{variance_ratios} \
                     --sparseGRMFile ~{GRM} \
                     --sparseGRMSampleIDFile ~{GRM_samples} \
                     --SAIGEOutputFile associations.txt \
                     --LOCO FALSE \
                     --chrom chr21
    #--groupFile group_file_processed 
    >>>

    runtime {
        docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		dx_instance_type: "mem2_ssd1_v2_x8"
    }

    output {
        File associations = "associations.txt"
    }
}

