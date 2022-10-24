version 1.1

import "tasks/preprocessing.wdl" as preprocessing
import "tasks/step0.wdl" as step0 
import "tasks/step1.wdl" as step1 
import "tasks/step2.wdl" as step2
import "tasks/step3.wdl" as step3
import "tasks/meta_analysis.wdl" as meta_analysis

workflow meta_analysis_workflow {
    input {
        Array[File] group_file
		Directory genotype_plinks
        Directory exome_plinks
		Array[File] QCd_population_IDs
        Array[File] superpopulation_sample_IDs
        File plink_binary 
        File split_ancs_python_script 
        Array[String] cohorts
		File? GRM
		File? GRM_samples
		File? pheno_file
	}

	Array[Int] cohort_i = range(length(group_file))
	
	scatter (i in cohort_i) {
		call preprocessing.split {
    	    input :
    	        genotype_plink_bed = genotype_plink_bed[i],
    	        genotype_plink_bim = genotype_plink_bim[i],
    	        genotype_plink_fam = genotype_plink_fam[i],
    	        QCd_population_IDs = QCd_population_IDs[i],
    	        superpopulation_sample_IDs = superpopulation_sample_IDs[i],
    	        ancestry = cohorts[i],
    	        split_ancs_python_script = split_ancs_python_script,
    	        plink_binary = plink_binary
    	}
		
		# Call redundant - use precalculated global GRM for 450k
    	#call step0.create_GRM {
    	#    input :
    	#        subset_plink_bed = split.subset_genotype_plink_bed,
    	#        subset_plink_bim = split.subset_genotype_plink_bim,
    	#        subset_plink_fam = split.subset_genotype_plink_fam
    	#}
    	
    	call step1.fitNULLGLMM { 
    		 input : 
    		     GRM = GRM,
    	   	 	 GRM_samples = GRM_samples,
    	   		 pheno_list = pheno_file,
    	    	 subset_plink_bed = split.subset_genotype_plink_bed,
    	    	 subset_plink_bim = split.subset_genotype_plink_bim,
    	         subset_plink_fam = split.subset_genotype_plink_fam
    	}
    	
    	call step2.SPAtests{
    		input : 
    			group_file = group_file[i],
    	        model_file = fitNULLGLMM.model_file,
    		    variance_ratios = fitNULLGLMM.variance_ratios,
    	     	GRM = create_GRM.GRM,
    	    	GRM_samples = create_GRM.GRM_samples,
    	    	exome_plink_bed = exome_plink_bed[i],
    	    	exome_plink_bim = exome_plink_bim[i],
    	    	exome_plink_fam = exome_plink_fam[i]
    			
    	}

    	call step3.LDmat{
    	    input :
				cohort = cohorts[i],
    	        group_file = group_file[i],
    	        sample_file = split.ancestry_sample_list,
    	        exome_plink_bed = exome_plink_bed[i],
    	        exome_plink_bim = exome_plink_bim[i],
    	        exome_plink_fam = exome_plink_fam[i]

    	}
			
	}
	
	call meta_analysis.analyse {
		input :
			cohorts = cohorts,
			info_files = LDmat.info_file,
			LD_mats = LDmat.LD_mats,
			associations = SPAtests.associations
	}
	
	output {
        File comb_associations = analyse.comb_associations
    }
}
