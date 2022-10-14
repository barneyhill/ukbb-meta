workflow=$(dxCompiler compile meta_analysis.wdl --folder /ukbb-meta/workflows/ -f)
dx run $workflow -i stage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                                       -i stage-common.ancestry=EAS \
                                       -i stage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                                       -i stage-common.genotype_plink_bed=file-FxXb5fjJkF6K07FF9X4Q2PG0 \
                                       -i stage-common.genotype_plink_bim=file-FxXZxk8JkF67GV2z7v5ZqFzQ \
                                       -i stage-common.genotype_plink_fam=file-GBvq9j0Jj6BPvX8V4v9BGKJq \
                                       -i stage-common.plink_binary=file-GJ4YPx0Jg8JvPZ6557jJQG6b \
                                       -i stage-common.split_ancs_python_script=file-GJ4ZYQQJg8Jv9y8g1zQkzFKX \
                                       -i stage-common.group_file=file-GJ2fqQQJg8Jk3PY3G5YPBzX8 \
                                       -i stage-common.exome_plink_bed=file-GJ43Zk0Jg8Jvzp3v0yjjPFf0 \
                                       -i stage-common.exome_plink_bim=file-GJ43b5QJg8JQJPb8K17YJ48k \
                                       -i stage-common.exome_plink_fam=file-GJ43b68Jg8Jz49ZXPvq9y3zf -y

