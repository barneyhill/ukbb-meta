version 1.1

import preprocessing.wdl as preprocessing
#import step0.wdl as step0 
#import step1.wdl as step1 
#import step2.wdl as step2
#import step3.wdl as step3

workflow meta-analysis {
    input {
        File genotype_plink_bed
        File genotype_plink_bim
        File genotype_plink_fam
        File QCd_population_IDs
        File superpopulation_sample_IDs
        String ancestry
    }

    call preprocessing {
        input : 
                genotype_plink_bed = genotype_plink_bed,
                genotype_plink_bim = genotype_plink_bim,
                genotype_plink_fam = genotype_plink_fam,
                QCd_population_IDs = QCd_population_IDs,
                superpopulation_sample_IDs = superpopulation_sample_IDs,
                ancestry = ancestry
    }

    output {
        File bai = preprocessing.pheno_list
    }
}
