version 1.1

task get_link {
    input {
		String path
		String type
		Int chrom
    }

    command <<<
    set -ex
	
	if [ "~{type}" == "genotype" ]; then
		plink_file="~{"ukb22418_c" + chrom + "_b0_v2"}"
	else
		plink_file="~{"ukb_wes_450k.qced.chr" + chrom}"
	fi
	
	
	dx find data --name "$plink_file.bed" --path "~{path}" --norecurse --brief > bed.txt
	dx find data --name "$plink_file.bim" --path "~{path}" --norecurse --brief > bim.txt
	dx find data --name "$plink_file.fam" --path "~{path}" --norecurse --brief > fam.txt
	
    >>>

	runtime {
	   	dx_instance_type: "mem2_ssd1_v2_x2"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
	    }

	}			
	
    output {
		File bed = "dx://" + read_string("bed.txt")
		File bim = "dx://" + read_string("bim.txt")
		File fam = "dx://" + read_string("fam.txt")
    }
}
