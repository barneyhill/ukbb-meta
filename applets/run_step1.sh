dx build -f saige-step1

anc="EAS"

dx run saige-step1 -i plink_bed=/ukbb-meta/data/preprocessing/${anc}_exome_subset.bed \
                   -i plink_bim=/ukbb-meta/data/preprocessing/${anc}_exome_subset.bim \
                   -i plink_fam=/ukbb-meta/data/preprocessing/${anc}_exome_subset.fam \
                   -i GRM=/ukbb-meta/data/step0/${anc}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx \
                   -i GRM_samples=/ukbb-meta/data/step0/${anc}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
                   -i pheno_list=/ukbb-meta/data/preprocessing/${anc}_pheno.txt \
                   -i cohort=$anc \
                   --instance-type "mem3_ssd1_v2_x2" --priority normal --destination ukbb-meta/data/step1/ -y 
#                   --ssh --delay-workspace-destruction

