version 1.1

import "preprocessing.wdl" as preprocessing
import "step0.wdl" as step0 
import "step1.wdl" as step1 
import "step2.wdl" as step2
import "step3.wdl" as step3

workflow meta_analysis {
    input {
        File group_file
        File exome_plink_bed
        File exome_plink_bim
        File exome_plink_fam 
        File genotype_plink_bed
        File genotype_plink_bim
        File genotype_plink_fam
        File QCd_population_IDs
        File superpopulation_sample_IDs
        File plink_binary
        File split_ancs_python_script
        String ancestry
    }

    call preprocessing.split {
        input :
            genotype_plink_bed = genotype_plink_bed,
            genotype_plink_bim = genotype_plink_bim,
            genotype_plink_fam = genotype_plink_fam,
            QCd_population_IDs = QCd_population_IDs,
            superpopulation_sample_IDs = superpopulation_sample_IDs,
            ancestry = ancestry,
            split_ancs_python_script = split_ancs_python_script,
            plink_binary = plink_binary
    }

    call step0.create_GRM {
        input :
            subset_plink_bed = split.subset_genotype_plink_bed,
            subset_plink_bim = split.subset_genotype_plink_bim,
            subset_plink_fam = split.subset_genotype_plink_fam
    }
	
    call step1.fitNULLGLMM { 
		 input : 
		     GRM = create_GRM.GRM,
	   	 	 GRM_samples = create_GRM.GRM_samples,
       		 pheno_list = split.pheno_list,
        	 subset_plink_bed = split.subset_genotype_plink_bed,
        	 subset_plink_bim = split.subset_genotype_plink_bim,
             subset_plink_fam = split.subset_genotype_plink_fam
	}
	
	call step2.SPAtests{
		input : 
			group_file = group_file,
	        model_file = fitNULLGLMM.model_file,
    	    variance_ratios = fitNULLGLMM.variance_ratios,
         	GRM = create_GRM.GRM,
        	GRM_samples = create_GRM.GRM_samples,
        	exome_plink_bed = exome_plink_bed,
        	exome_plink_bim = exome_plink_bim,
        	exome_plink_fam = exome_plink_fam
			
	}

    call step3.LDmat{
        input :
            group_file = group_file,
            sample_file = split.ancestry_sample_list,
            exome_plink_bed = exome_plink_bed,
            exome_plink_bim = exome_plink_bim,
            exome_plink_fam = exome_plink_fam

    }

    output {
        Array[File] LD_mat = LDmat.LD_mats
    }
}
