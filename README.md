# ukbb-meta

Data stored in wes_450k/ukbb-meta/data/ on the RAP

SAIGE docker file saved in wes_450k/ukbb-meta/docker/:

```docker pull wzhou88/saige:1.1.6.1```

### Pipeline to run generate input data for https://github.com/barneyhill/Rare_Variant_Meta. Ancestries will be treated as cohorts.
- ✅ Preprocessing: Seperate ukbb plink files into respective ancestries/cohorts
  - Input data:
    - wes_450k/Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2
      - .bed
      - .bim
      - .fam
    - wes_450k/data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt
    - wes_450k/data/superpopulation_labels.tsv
    - cohort (ancestry)
  - Output data:
    - plink_files:
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.bed
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.bim
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.fam
     - wes_450k/ukbb-meta/data/preprocessing/${cohort}_comb.txt # anc_sample_list
     - wes_450k/ukbb-meta/data/preprocessing/${cohort}_pheno # pheno_list

- ✅ Step0: Generate GRM's for respective cohorts
  - Input data:
    - cohort (ancestry)
    - plink_files:
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.bed
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.bim
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.fam
  - Output data
    - wes_450k/ukbb-meta/data/step0/${cohort}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx # saige generated GRM (GRM)
    - wes_450k/ukbb-meta/data/step0/${cohort}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt # saige generated GRM sample list (GRM_samples)

- ✅ Step1: fitting the null linear/logistic mixed model using the sparse GRM and estimating variance ratios
  - Input data:
    - plink_files:
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.bed
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.bim
      - wes_450k/ukbb-meta/data/preprocessing/${cohort}_exome_subset.fam
    - wes_450k/ukbb-meta/data/step0/${cohort}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx # saige generated GRM (GRM)
    - wes_450k/ukbb-meta/data/step0/${cohort}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt # saige generated GRM sample list (GRM_samples)
    - wes_450k/ukbb-meta/data/preprocessing/${cohort}_pheno # pheno_list
  - Output data
    - wes_450k/ukbb-meta/data/step1/${cohort}.rda # null model
    - wes_450k/ukbb-meta/data/step1/${cohort}.varianceRatio.txt # variance ratios

- Step2: Performing exome-wide gene-based tests
- ✅ FINAL: Rare_Variant_Meta
