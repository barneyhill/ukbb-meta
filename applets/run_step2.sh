dx build -f saige-step2

anc="EAS"

dx run saige-step2 -i vcf_file=file-GJ3FV48Jg8Jyyy4vFkz0ZQ83 \
                   -i vcf_index=file-GJ3FfP8Jf9xPk2qZPx5y91BZ \
                   -i GRM=/ukbb-meta/data/step0/${anc}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx \
                   -i GRM_samples=/ukbb-meta/data/step0/${anc}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
                   -i variance_ratios=/ukbb-meta/data/step1/${anc}.varianceRatio.txt \
                   -i model_file=/ukbb-meta/data/step1/${anc}.rda \
        		   -i group_file=/ukbb-meta/data/annotations/UKBexomeOQFE_chr21.gene.anno.hg38_multianno.lMS.group.chrpos.SAIGEGENEplus.txt \
                   -i sample_file=/ukbb-meta/data/preprocessing/EAS_comb.txt \
                   -i cohort=$anc \
                   --instance-type "mem3_ssd1_v2_x16" --priority high --destination ukbb-meta/data/step2/ --ssh

