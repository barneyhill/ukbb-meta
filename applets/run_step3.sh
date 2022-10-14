dx build -f saige-step3

anc="EAS"

dx run saige-step3 -i vcf_file=file-GJ3FV48Jg8Jyyy4vFkz0ZQ83 \
                   -i vcf_index=file-GJ3FfP8Jf9xPk2qZPx5y91BZ \
        		   -i group_file=/ukbb-meta/data/annotations/UKBexomeOQFE_chr21.gene.anno.hg38_multianno.lMS.group.chrpos.SAIGEGENEplus.txt \
                   -i global_sample_file=/ukbb-meta/data/preprocessing/EAS_comb.txt\
                   -i local_sample_file=/ukbb-meta/data/step0/EAS_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
                   -i cohort=$anc \
                   --instance-type "mem3_ssd1_v2_x16" --priority high --destination ukbb-meta/data/step3/ --ssh

