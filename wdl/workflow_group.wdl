version 1.1

import "tasks/preprocessing.wdl" as preprocessing
import "tasks/step0.wdl" as step0 
import "tasks/step1.wdl" as step1 
import "tasks/step2_grp.wdl" as step2
import "tasks/step3.wdl" as step3
import "tasks/meta_analysis.wdl" as meta_analysis
import "tasks/get_link.wdl" as get_link

workflow meta_analysis_workflow {
	input {
		Array[File] group_file
		Array[String] genotype_paths
		Array[String] exome_paths
		Array[File] QCd_population_IDs
		Array[File] superpopulation_sample_IDs
		File plink_binary 
		File split_ancs_python_script 
		Array[String] cohorts
		File pheno_list
		String pheno
		File GRM
		File GRM_samples
		File var_subset
	}

	Array[Int] cohorts_i = range(length(group_file))
	Array[Int] chrs = [20, 21]
	
	scatter (chr in chrs){
		call get_link.get_link as genotype {
			input:
				path = genotype_paths[2],
				chrom = chr,
				type = "genotype"
		}
	
		call get_link.get_link as exome {
			input:
				path = exome_paths[2],
				chrom = chr,
				type = "exome"
		}

		call preprocessing.split {
			input :
				genotype_bed = genotype.bed,
				genotype_bim = genotype.bim,
				genotype_fam = genotype.fam,
		    	QCd_population_IDs = QCd_population_IDs[2],
		    	superpopulation_sample_IDs = superpopulation_sample_IDs[2],
		    	ancestry = cohorts[2],
		    	split_ancs_python_script = split_ancs_python_script,
		    	plink_binary = plink_binary
	 	}

 		#call step0.create_GRM {
     		#    	input :
     	        #		subset_plink_bed = split.subset_genotype_plink_bed,
     	        #		subset_plink_bim = split.subset_genotype_plink_bim,
		#		subset_plink_fam = split.subset_genotype_plink_fam
		#}	
		
		call step1.fitNULLGLMM { 
			input : 
				GRM = GRM,
				GRM_samples = GRM_samples,
				pheno_list = pheno_list,
				pheno = pheno,
				genotype_bed = split.subset_genotype_plink_bed,
				genotype_bim = split.subset_genotype_plink_bim,
				genotype_fam = split.subset_genotype_plink_fam,
				sample_file = split.ancestry_sample_list
		}

		call step2.SPAtests{
			input :
				group_file = group_file[chr-20] 
				sample_file = split.ancestry_sample_list,
				model_file = fitNULLGLMM.model_file,
				variance_ratios = fitNULLGLMM.variance_ratios,
				GRM = GRM,
				GRM_samples = GRM_samples,
				exome_bed = exome.bed,
				exome_bim = exome.bim,
				exome_fam = exome.fam,
				chrom = chr,
				var_subset= var_subset    		
		}
	}

	output {
        Array[File] comb_associations = SPAtests.associations
    }
}
