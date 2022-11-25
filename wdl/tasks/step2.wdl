version 1.1

task SPAtests {
    input {
	String test_type
	File group_file
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

    sed 's/^chr//g' ~{exome_bim} > exome.bim
    
    if [ "~{test_type}" = "variant" ]; then

    	step2_SPAtests.R --bedFile ~{exome_bed} \
			     --bimFile exome.bim \
			     --famFile ~{exome_fam} \
			     --GMMATmodelFile ~{model_file} \
			     --varianceRatioFile ~{variance_ratios} \
			     --sparseGRMFile ~{GRM} \
			     --sparseGRMSampleIDFile ~{GRM_samples} \
			     --SAIGEOutputFile associations.txt \
			     --LOCO FALSE \
			     --is_Firth_beta TRUE \
			     --pCutoffforFirth=0.05 \
			     --is_fastTest=TRUE \
			     --subSampleFile sample_file_trim \
			     --chrom "~{chrom}"

	touch associations.txt.singleAssoc.txt

    elif [ "~{test_type}" = "gene" ]; then
    	sed 's/ chr~{chrom}:/ ~{chrom}:/g' ~{group_file} > group_file_processed
    	
	step2_SPAtests.R --bedFile ~{exome_bed} \
			     --bimFile exome.bim \
			     --famFile ~{exome_fam} \
			     --GMMATmodelFile ~{model_file} \
			     --varianceRatioFile ~{variance_ratios} \
			     --sparseGRMFile ~{GRM} \
			     --sparseGRMSampleIDFile ~{GRM_samples} \
			     --SAIGEOutputFile associations.txt \
			     --LOCO FALSE \
			     --is_Firth_beta TRUE \
			     --pCutoffforFirth=0.05 \
			     --is_fastTest=TRUE \
			     --subSampleFile sample_file_trim \
			     --chrom "~{chrom}" \
			     --groupFile=group_file_processed \
			     --annotation_in_groupTest damaging_missense,pLoF,synonymous,pLoF:damaging_missense,damaging_missense:pLoF:synonymous

    fi

    >>>

	runtime{
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		disks: "local-disk ${size(exome_bed, "GB")+20} SSD"
                memory: "${size(exome_bed, "GB") + size(GRM, "GB") + 8} GB"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
		}
	}

    output {
        File associations = "associations.txt"
	File variant_associations_if_gene = "associations.txt.singleAssoc.txt"
    }
}

