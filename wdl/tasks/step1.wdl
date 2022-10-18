version 1.0

task fitNULLGLMM {
	input {
		File GRM
		File GRM_samples
		File pheno_list
		File subset_plink_bed
		File subset_plink_bim
		File subset_plink_fam
	}

	command <<<
	set -ex

	step1_fitNULLGLMM.R --sparseGRMFile ~{GRM} \
						--sparseGRMSampleIDFile ~{GRM_samples} \
						--useSparseGRMtoFitNULL FALSE \
						--phenoFile ~{pheno_list} \
						--phenoCol=y_binary \
						--sampleIDColinphenoFile=IID \
						--useSparseGRMforVarRatio=TRUE	\
						--bedFile ~{subset_plink_bed} \
						--bimFile ~{subset_plink_bim} \
						--famFile ~{subset_plink_fam} \
						--outputPrefix output \
						--nThreads=$(nproc) \
						--traitType=binary

	>>>

	runtime {
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		dx_instance_type: "mem2_ssd1_v2_x2"
	}

	output {
		File model_file = glob("*.rda")[0]
		File variance_ratios = glob("*.varianceRatio.txt")[0]
	}
}

