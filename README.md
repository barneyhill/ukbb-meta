# ukbb-meta

Pipeline to run generate input data for https://github.com/barneyhill/Rare_Variant_Meta. Ancestries will be treated as cohorts.
- ✅ Preprocessing: Seperate ukbb plink files into respective ancestries/cohorts
  - Input data:
    - wes_450k/Bulk/Genotype Results/Genotype calls/ukb22418_c21_b0_v2*
    - wes_450k/data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt
    - wes_450k/data/superpopulation_labels.tsv
  - Output data:
      - wes_450k/ukbb-meta/data/preprocessing/* (plink files for different cohorts)
- Step0: Generate GRM's for respective cohorts
  - Input data:
    - wes_450k/ukbb-meta/data/preprocessing/* (plink files for different cohorts)
- Step1: fitting the null linear/logistic mixed model using the sparse GRM and estimating variance ratios
- Step2: Performing exome-wide gene-based tests
- Run Rare_Variant_Meta

Data stored in wes_450k/ukbb-meta/data on the RAP
