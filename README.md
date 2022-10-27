# ukbb-meta

### Summary
A DNAnexus wdl pipeline to perform exome-wide association tests across multiple cohorts and meta-analyse these combined associations.

![Screenshot from 2022-10-27 14-50-05](https://user-images.githubusercontent.com/43707014/198302897-1d4cf9ba-97cb-474c-aa21-ef785ac56579.png)

### Usage
```
cd wdl
bash run_workflow.sh
```
### Requirements
- [dxCompiler](https://github.com/dnanexus/dxCompiler)
- [dx-toolkit](https://github.com/dnanexus/dx-toolkit)

### Cohort Specific Inputs:
- Genotype path: DNAnexus path containing genotype plink files
- Exome path: DNAnexus path containing exome plink files
- Annotations file
- Phenotype list

### Docker Files
[SAIGE](https://github.com/saigegit/SAIGE) docker file saved in wes_450k/ukbb-meta/docker/

[Rare_Variant_Meta](https://github.com/barneyhill/Rare_Variant_Meta/) docker file pulled from https://ghcr.io/barneyhill/rare_variant_meta:release
