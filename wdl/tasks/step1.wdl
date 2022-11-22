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
		String covariates
		String categorical_covariates
		String trait_type
	}

	command <<<
	set -ex
	apt-get install plink2
		
	plink2 --bed ~{genotype_bed} --bim ~{genotype_bim} --fam ~{genotype_fam} --freq counts --out out
	cat <(tail -n +2 out.acount | awk '(($6-$5) < 20 && ($6-$5) >= 10) || ($5 < 20 && $5 >= 10) {print $2}' | shuf -n 5000) \
	 <(tail -n +2 out.acount | awk ' $5 >= 20 && ($6-$5)>= 20 {print $2}' | shuf -n 5000) > out.markerid.list
    
	markers=$(wc -l < out.markerid.list)
	if test $markers -gt 1000
	then
		plink2 --bed ~{genotype_bed} --bim ~{genotype_bim} --fam ~{genotype_fam} --extract out.markerid.list --make-bed --out genotype_subset_mod 
	else
		plink2 --bed ~{genotype_bed} --bim ~{genotype_bim} --fam ~{genotype_fam} --no-fid --make-bed --out genotype_subset_mod 
	fi	
	
	cat ~{sample_file} | awk -F " " '{ print $1 }' > sample_file_trim	
										
	step1_fitNULLGLMM.R --sparseGRMFile ~{GRM} \
						--sparseGRMSampleIDFile ~{GRM_samples} \
						--useSparseGRMtoFitNULL TRUE \
						--phenoFile ~{pheno_list} \
						--phenoCol="~{pheno}" \
						--sampleIDColinphenoFile="eid" \
						--covarColList="~{covariates}" \
						--qCovarColList="~{categorical_covariates}" \
						--bedFile genotype_subset_mod.bed \
						--bimFile genotype_subset_mod.bim \
						--famFile genotype_subset_mod.fam \
						--outputPrefix output \
						--nThreads=$(nproc) \
						--SampleIDIncludeFile sample_file_trim \
						--traitType="~{trait_type}" \
						--invNormalize=TRUE \
						--skipVarianceRatioEstimation=FALSE
	>>>

	runtime{
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
    	dx_instance_type: "mem3_ssd1_v2_x4"
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

