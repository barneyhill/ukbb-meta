version 1.1

task split {
    input {
        File plink_binary
        File split_ancs_python_script
        File genotype_plink_bed
        File genotype_plink_bim
        File genotype_plink_fam
        File QCd_population_IDs
        File superpopulation_sample_IDs
        String ancestry
    }

    command <<<
    set -ex
    ls -al
    python3 ~{split_ancs_python_script} --qced_sampled_id_file ~{QCd_population_IDs} --superpopulation_file ~{superpopulation_sample_IDs} --anc ~{ancestry}
    ls -al
    paste ~{ancestry}.txt ~{ancestry}.txt > comb.txt    
    ls -al
    chmod u+x ~{plink_binary}
    ~{plink_binary} --bed ~{genotype_plink_bed} --bim ~{genotype_plink_bim} --fam ~{genotype_plink_fam} --keep comb.txt --no-fid --make-bed --out exome_subset
    ls -al
    >>>
	
	runtime {
		dx_instance_type: "mem2_ssd1_v2_x2"
	}
	
    output {
        File subset_genotype_plink_bed = "exome_subset.bed"
        File subset_genotype_plink_bim = "exome_subset.bim"
        File subset_genotype_plink_fam = "exome_subset.fam"
        File ancestry_sample_list = "comb.txt" 
        File pheno_list = "pheno.txt"
    }
}
