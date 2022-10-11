dx build -f saige-step3

anc="EAS"

dx run saige-step3 -i vcf_file=/data/05_export_to_vcf/ukb_wes_450k.qced.chr21.vcf.gz \
        		   -i group_file=/ukbb-meta/data/annotations/c21_b0_v1.avoutput.hg38_multianno.csv \
                   -i cohort=$anc \
                   --instance-type "mem3_ssd1_v2_x4" --priority low --destination ukbb-meta/data/step3/ --ssh

