dx build -f saige-step0
dx run saige-step0 -i plink_bed=/ukbb-meta/data/preprocessing/AMR_exome_subset.bed \
                   -i plink_bim=/ukbb-meta/data/preprocessing/AMR_exome_subset.bim \
                   -i plink_fam=/ukbb-meta/data/preprocessing/AMR_exome_subset.fam \
                   -i cohort="EUR" \
                   --instance-type "mem3_ssd1_v2_x2" --priority low --destination ukbb-meta/data/step0/ -y

