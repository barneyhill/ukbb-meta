#export workflow="workflow-GJ78Y88Jg8JvV3v38z333BGZ"
workflow=$(dxCompiler compile workflow.wdl --folder /ukbb-meta/workflows/ -f)
dx run $workflow \
                                       -i stage-common.cohorts="SAS" \
                                       -i stage-common.cohorts="AFR" \
                                       -i stage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                                       -i stage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                                       -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                                       -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                                       -istage-common.genotype_plink_bed="Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2.bed" -istage-common.genotype_plink_bed="Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2.bed" \
                                       -istage-common.genotype_plink_bim="Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2.bim" -istage-common.genotype_plink_bim="Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2.bim" \
                                       -istage-common.genotype_plink_fam="Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2.fam" -istage-common.genotype_plink_fam="Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2.fam" \
                                       -istage-common.group_file="ukbb-meta/data/annotations/UKBexomeOQFE_chr21.gene.anno.hg38_multianno.lMS.group.chrpos.SAIGEGENEplus.txt" -istage-common.group_file="ukbb-meta/data/annotations/UKBexomeOQFE_chr21.gene.anno.hg38_multianno.lMS.group.chrpos.SAIGEGENEplus.txt" \
                                       -istage-common.exome_plink_bed="data/04_final_filter/plink/ukb_wes_450k.qced.chr21.bed" -istage-common.exome_plink_bed="data/04_final_filter/plink/ukb_wes_450k.qced.chr21.bed" \
									   -istage-common.exome_plink_bim="data/04_final_filter/plink/ukb_wes_450k.qced.chr21.bim" -istage-common.exome_plink_bim="data/04_final_filter/plink/ukb_wes_450k.qced.chr21.bim" \
                                       -istage-common.exome_plink_fam="data/04_final_filter/plink/ukb_wes_450k.qced.chr21.fam" -istage-common.exome_plink_fam="data/04_final_filter/plink/ukb_wes_450k.qced.chr21.fam" \
									   -istage-common.plink_binary="file-GJ4YPx0Jg8JvPZ6557jJQG6b" -istage-common.split_ancs_python_script="file-GJ4ZYQQJg8Jv9y8g1zQkzFKX" \
									   --destination ukbb-meta/data/workflow -y 
