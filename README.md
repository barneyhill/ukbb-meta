# ukbb-meta

Pipeline to run generate input data for https://github.com/barneyhill/Rare_Variant_Meta. Ancestries will be treated as cohorts.
- Preprocessing: Seperate ukbb plink files into respective ancestries/cohorts
- Step0: Generate GRM's for respective cohorts
- Step1: fitting the null linear/logistic mixed model using the sparse GRM and estimating variance ratios
- Step2: Performing exome-wide gene-based tests
- Run Rare_Variant_Meta
