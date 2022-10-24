#export workflow="workflow-GJ78Y88Jg8JvV3v38z333BGZ"
workflow=$(dxCompiler compile workflow_chr.wdl --folder /ukbb-meta/workflows/ -f)
dx run $workflow \
                                       -i stage-common.cohorts="AFR" \
                                       -i stage-common.cohorts="SAS" \
                                       -i stage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                                       -i stage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                                       -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                                       -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                                       -istage-common.group_file="ukbb-meta/data/annotations/UKBexomeOQFE_chr21.gene.anno.hg38_multianno.lMS.group.chrpos.SAIGEGENEplus.txt" \
									   -istage-common.group_file="ukbb-meta/data/annotations/UKBexomeOQFE_chr21.gene.anno.hg38_multianno.lMS.group.chrpos.SAIGEGENEplus.txt" \
									   -istage-common.plink_binary="file-GJ4YPx0Jg8JvPZ6557jJQG6b" -istage-common.split_ancs_python_script="file-GJ4ZYQQJg8Jv9y8g1zQkzFKX" \
                                       -istage-common.GRM="saige_pipeline/data/00_set_up/ukb_array_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx" \
									   -istage-common.GRM="saige_pipeline/data/00_set_up/ukb_array_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx" \
									   -istage-common.GRM_samples="saige_pipeline/data/00_set_up/ukb_array_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt" \
			    		      		   -istage-common.GRM_samples="saige_pipeline/data/00_set_up/ukb_array_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt" \
									   -istage-common.genotype_plinks="Bulk/Genotype Results/Genotype calls/ukb22418_c1_b0_v2.bed" \
									   -istage-common.genotype_plinks="Bulk/Genotype Results/Genotype calls/ukb22418_c1_b0_v2.bed" \
									   -istage-common.exome_plinks="data/05_export_to_plink/ukb_wes_450k.qced.chr1.bed" \
									   -istage-common.exome_plinks="data/05_export_to_plink/ukb_wes_450k.qced.chr1.bed" \
									   --destination ukbb-meta/data/workflow -y
