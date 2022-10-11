dx build -f saige-step2

anc="EAS"

dx run saige-step2 -i vcf_file=/data/05_export_to_vcf/ukb_wes_450k.qced.chr21.vcf.bgz \
                   -i GRM=/ukbb-meta/data/step0/${anc}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx \
                   -i GRM_samples=/ukbb-meta/data/step0/${anc}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
                   -i variance_ratios=/ukbb-meta/data/step1/${anc}.varianceRatio.txt \
                   -i model_file=/ukbb-meta/data/step1/${anc}.rda \
        		   -i group_file=/ukbb-meta/data/annotations/c21_b0_v1.avoutput.hg38_multianno.csv \
                   -i cohort=$anc \
                   --instance-type "mem2_ssd1_v2_x4" --priority low --destination ukbb-meta/data/step2/ --ssh

