version 1.0

task create_GRM {
    input {
        File subset_plink_bed
        File subset_plink_bim
        File subset_plink_fam
    }

    command <<<
    set -ex

    createSparseGRM.R --bedFile ~{subset_plink_bed} \
                      --bimFile ~{subset_plink_bim} \
                      --famFile ~{subset_plink_fam} \
                      --outputPrefix GRM \
                      --nThreads=$(nproc)
    >>>

    runtime {
        docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		dx_instance_type: "mem2_ssd1_v2_x2"
	}

    output {
        File GRM = glob("*.mtx")[0]
        File GRM_samples = glob("*.sampleIDs.txt")[0]
    }
}

