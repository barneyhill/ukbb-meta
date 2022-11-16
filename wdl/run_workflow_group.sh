#export workflow="workflow-GJ78Y88Jg8JvV3v38z333BGZ"
workflow=$(dxCompiler compile workflow_group.wdl --folder /ukbb-meta/workflows/ -f)
dx run $workflow \
								 -istage-common.cohorts="AFR" \
						     -istage-common.cohorts="SAS" \
						     -istage-common.cohorts="EUR" \
	               -istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
	               -istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                 -istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
	               -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
	               -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
	               -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                 -istage-common.group_file="ukbb-meta/data/annotations/merged_exome_annos_VEP.txt" \
							   -istage-common.group_file="ukbb-meta/data/annotations/merged_exome_annos_VEP.txt" \
							   -istage-common.group_file="ukbb-meta/data/annotations/merged_exome_annos_VEP.txt" \
							   -istage-common.plink_binary="file-GJ4YPx0Jg8JvPZ6557jJQG6b" -istage-common.split_ancs_python_script="file-GJ4ZYQQJg8Jv9y8g1zQkzFKX" \
							   -istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
							   -istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
							   -istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
							   -istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
							   -istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
							   -istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
								 -istage-common.pheno_list="ukbb-meta/data/step1/merged_test.tsv" \
								 -istage-common.pheno="Type_two_diabetes" \
								-istage-common.GRM="file-GFJb8kjJZgJJ37pV53vYkfKx" \
								 -istage-common.var_subset="ukbb-meta/data/step2/lof.txt" \
								-istage-common.GRM_samples="file-GFJb8kjJZgJJ37pV53vYkfKq" \
							   --destination ukbb-meta/data/workflow --priority low -y
