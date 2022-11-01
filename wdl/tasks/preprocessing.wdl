version 1.1

task split {
    input {
        File plink_binary
        File split_ancs_python_script
		File genotype_bed
		File genotype_bim
		File genotype_fam
        File QCd_population_IDs
        File superpopulation_sample_IDs
        String ancestry
    }

    command <<<
    set -ex
	
	apt-get install plink2
    
	python3 ~{split_ancs_python_script} --qced_sampled_id_file ~{QCd_population_IDs} --superpopulation_file ~{superpopulation_sample_IDs} --anc ~{ancestry}
	
    paste ~{ancestry}.txt ~{ancestry}.txt > comb.txt    
    chmod u+x ~{plink_binary}
	
	plink2 --bed ~{genotype_bed} --bim ~{genotype_bim} --fam ~{genotype_fam} --freq counts --out out
	cat <(tail -n +2 out.acount | awk '(($6-$5) < 20 && ($6-$5) >= 10) || ($5 < 20 && $5 >= 10) {print $2}' | shuf -n 5000) \
	 <(tail -n +2 out.acount | awk ' $5 >= 20 && ($6-$5)>= 20 {print $2}' | shuf -n 5000) > out.markerid.list
    
	markers=$(wc -l < out.markerid.list)
	if test $markers -gt 1000
	then
		~{plink_binary} --bed ~{genotype_bed} --bim ~{genotype_bim} --fam ~{genotype_fam} -extract out.markerid.list --keep comb.txt --no-fid --make-bed --out genotype_subset 
	else
		~{plink_binary} --bed ~{genotype_bed} --bim ~{genotype_bim} --fam ~{genotype_fam} --keep comb.txt --no-fid --make-bed --out genotype_subset
		
	fi

	
    ls -al
    >>>

	runtime {
	   	dx_instance_type: "mem2_ssd1_v2_x2"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
	    }
	}			
	
    output {
        File subset_genotype_plink_bed = "genotype_subset.bed"
        File subset_genotype_plink_bim = "genotype_subset.bim"
        File subset_genotype_plink_fam = "genotype_subset.fam"
        File ancestry_sample_list = "comb.txt" 
    }
}
