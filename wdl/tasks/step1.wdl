version 1.1
 
task fitNULLGLMM {
	input {
		File GRM
		File GRM_samples
		File pheno_list
		File genotype_bed
		File genotype_bim
		File genotype_fam
		File sample_file
		String pheno 
	}

	command <<<
	set -ex
	
    cat ~{sample_file} | awk -F " " '{ print $1 }' > sample_file_trim	
										
	step1_fitNULLGLMM.R --sparseGRMFile ~{GRM} \
						--sparseGRMSampleIDFile ~{GRM_samples} \
						--useSparseGRMtoFitNULL TRUE \
						--phenoFile ~{pheno_list} \
						--phenoCol="~{pheno}" \
						--sampleIDColinphenoFile="eid" \
						--covarColList=PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 \
						--bedFile ~{genotype_bed} \
						--bimFile ~{genotype_bim} \
						--famFile ~{genotype_fam} \
						--outputPrefix output \
						--nThreads=$(nproc) \
						--SampleIDIncludeFile sample_file_trim \
						--traitType=binary \
						--skipVarianceRatioEstimation=FALSE
	>>>

	runtime{
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
    	dx_instance_type: "mem3_ssd1_v2_x2"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
	    }

	}

	output {
		File model_file = glob("*.rda")[0]
		File variance_ratios = glob("*.varianceRatio.txt")[0]
	}
}

