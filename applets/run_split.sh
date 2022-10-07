dx build -f split_plinks_by_anc

anc="EAS"

dx run split_plinks_by_anc -i QCd_pop_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                                       -i anc=$anc \
                                       -i superpopulation="data/superpopulation_labels.tsv" \
                                       -i plink_bed=file-FxXb5fjJkF6K07FF9X4Q2PG0 \
                                       -i plink_bim=file-FxXZxk8JkF67GV2z7v5ZqFzQ \
                                       -i plink_fam=file-GBvq9j0Jj6BPvX8V4v9BGKJq \
                                       --destination ukbb-meta/data/preprocessing/$anc \
                                       --instance-type "mem3_ssd1_v2_x2" --priority low --destination ukbb-meta/data/preprocessing/ -y
