version 1.1

task create_GRM {
    input {
        File subset_plink_bed
        File subset_plink_bim
        File subset_plink_fam
    }

    command <<<
    set -ex

    apt-get install plink2
    
    plink2 --bed ~{subset_plink_bed} --bim ~{subset_plink_bim} --fam ~{subset_plink_fam} --indep-pairwise 50 5 0.05 --make-bed --out genotype_subset_pruned 

    createSparseGRM.R --bedFile "genotype_subset_pruned.bed" \
                      --bimFile "genotype_subset_pruned.bim" \
                      --famFile "genotype_subset_pruned.fam" \
                      --outputPrefix GRM \
                      --nThreads=$(nproc) \
                      --numRandomMarkerforSparseKin=5000 \
                      --relatednessCutoff=0.05
    >>>

    runtime {
        docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		dx_instance_type: "mem2_ssd1_v2_x8"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
	    }

	}

    output {
        File GRM = glob("*.mtx")[0]
        File GRM_samples = glob("*.sampleIDs.txt")[0]
    }
}

