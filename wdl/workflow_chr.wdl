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
		Array[File] genotype_plinks
        Array[File]	exome_plinks
 		Array[File] QCd_population_IDs
        Array[File] superpopulation_sample_IDs
        File plink_binary 
        File split_ancs_python_script 
        Array[String] cohorts
		Array[File] GRM
		Array[File] GRM_samples
	}

	Array[Int] cohorts_i = range(length(group_file))
	Array[Int] chrs = [20, 21]

	scatter (cohort_and_chr in zip(cohorts_i, chrs)) {
		Int cohort = cohort_and_chr.left
		Int chr = cohort_and_chr.right	

		File genotype_plink_bed = sub(genotype_plinks[cohort], "c1", "c~{chr}")
		File genotype_plink_bim = sub(genotype_plink_bed, "bed", "bim") 
		File genotype_plink_fam = sub(genotype_plink_bed, "bed", "fam")	

        File exome_plink_bed = sub(exome_plinks[cohort], "chr1", "chr~{chr}")
        File exome_plink_bim = sub(exome_plink_bed, "bed", "bim")
        File exome_plink_fam = sub(exome_plink_bed, "bed", "fam")

		call preprocessing.split {
    	input :
    		genotype_plink_bed = genotype_plink_bed,
    		genotype_plink_bim = genotype_plink_bim,
    		genotype_plink_fam = genotype_plink_fam,
    		QCd_population_IDs = QCd_population_IDs[cohort],
    		superpopulation_sample_IDs = superpopulation_sample_IDs[cohort],
    		ancestry = cohorts[cohort],
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
    		 GRM = GRM[cohort],
    		 GRM_samples = GRM_samples[cohort],
    		 pheno_list = split.pheno_list,
    		 subset_plink_bed = split.subset_genotype_plink_bed,
    		 subset_plink_bim = split.subset_genotype_plink_bim,
    		 subset_plink_fam = split.subset_genotype_plink_fam
    	}
    	
    	call step2.SPAtests{
    	input : 
    		group_file = group_file[cohort],
    		model_file = fitNULLGLMM.model_file,
    		variance_ratios = fitNULLGLMM.variance_ratios,
    		GRM = GRM[cohort],
    		GRM_samples = GRM_samples[cohort],
    		exome_plink_bed = exome_plink_bed,
    		exome_plink_bim = exome_plink_bim,
    		exome_plink_fam = exome_plink_fam
    		
    	}

    	call step3.LDmat{
    	input :
			cohort = cohorts[cohort],
    		group_file = group_file[cohort],
    		sample_file = split.ancestry_sample_list,
    		exome_plink_bed = exome_plink_bed,
    		exome_plink_bim = exome_plink_bim,
    		exome_plink_fam = exome_plink_fam

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
