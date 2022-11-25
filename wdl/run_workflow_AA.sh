#export workflow="workflow-GJ78Y88Jg8JvV3v38z333BGZ"
workflow=$(dxCompiler compile workflow_no_meta.wdl --folder /ukbb-meta/workflows/ -f)
dx run $workflow \
	-istage-common.chrs=20 \
        -istage-common.chrs=21 \
	-istage-common.test_type="gene" \
        -istage-common.group_file="ukbb-meta/data/annotations/merged_exome_annos_VEP.txt" \
        -istage-common.group_file="ukbb-meta/data/annotations/merged_exome_annos_VEP.txt" \
	-istage-common.cohorts="EUR" \
	-istage-common.cohorts="EAS" \
	-istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
	-istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
	-istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
	-istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
	-istage-common.plink_binary="file-GJ4YPx0Jg8JvPZ6557jJQG6b" -istage-common.split_ancs_python_script="file-GJ4ZYQQJg8Jv9y8g1zQkzFKX" \
	-istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
	-istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
	-istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
	-istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
	-istage-common.pheno_list="ukbb-meta/data/step1/brava_phenos_covariates.tsv" \
	-istage-common.pheno="Hypertension" \
	-istage-common.GRM="file-GFJb8kjJZgJJ37pV53vYkfKx" \
	-istage-common.GRM_samples="file-GFJb8kjJZgJJ37pV53vYkfKq" \
	-istage-common.covariates="is_female,age,pc1,pc2,pc3,pc4,pc5,pc6,pc7,pc8,pc9,pc10,pc11,pc12,pc13,pc14,pc15,pc16,pc17,pc18,pc19,pc20,pc21,assessment_centre,age2,is_female_age,is_female_age2" \
	-istage-common.categorical_covariates="assessment_centre,is_female" \
	-istage-common.trait_type="binary" \
	--destination ukbb-meta/data/workflow --priority low -y
