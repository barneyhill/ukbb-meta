import sys
import pandas as pd
import matplotlib.pyplot as plt
import math
import numpy as np

assocs_meta = pd.read_csv(sys.argv[1], sep=' ')
assocs_afr = pd.read_csv(sys.argv[2], sep='\t')
assocs_sas = pd.read_csv(sys.argv[3], sep='\t')

assocs_afr = assocs_afr.loc[assocs_afr["Group"]=="missense;lof;synonymous"]
assocs_sas = assocs_sas.loc[assocs_sas["Group"]=="missense;lof;synonymous"]

gene_list = list(set(assocs_meta["GENE"]) & set(assocs_afr["Region"]) & set(assocs_sas["Region"]))

print(len(gene_list))

#assocs_afr = assocs_afr.loc[assocs_afr["Region"].isin(gene_list)] 
#assocs_sas = assocs_sas.loc[assocs_sas["Region"].isin(gene_list)]

print(assocs_meta.shape, assocs_sas.shape, assocs_afr.shape)
print(assocs_meta, assocs_sas, assocs_afr)

assocs_meta = assocs_meta.loc[assocs_meta["GENE"].isin(gene_list)]
assocs_afr = assocs_afr.loc[assocs_afr["Region"].isin(gene_list)]

fig, ax = plt.subplots()

#meta_sorted = assocs_meta.sort_values(by="Pval")
#gene_order = list(meta_sorted["GENE"])

#ps = np.linspace(0,1,num=len(gene_order)+1)[1:]

afr_sorted = assocs_afr.sort_values(by="Pvalue")
gene_order = list(afr_sorted["Region"])

print()


#for gene, p in zip(gene_order, ps):
for gene in gene_order:
	print(gene, float(assocs_afr[assocs_afr["Region"] == gene]["Pvalue"]),float(assocs_sas[assocs_sas["Region"] == gene]["Pvalue"]))
	ax.scatter(float(assocs_afr.loc[assocs_afr["Region"] == gene]["Pvalue"]),
		   float(assocs_sas.loc[assocs_sas["Region"] == gene]["Pvalue"]), color="red")
	#print(gene,p,assocs_meta[assocs_meta["GENE"] == gene]["Pval"], assocs_afr[assocs_afr["Region"] == gene]["Pvalue_SKAT"],assocs_sas[assocs_sas["Region"] == gene]["Pvalue_SKAT"])
	#ax.scatter(-math.log(p), -math.log(float(assocs_meta.loc[assocs_meta["GENE"] == gene]["Pval"])), color="blue",s=10)
	#ax.scatter(-math.log(p), -math.log(float(assocs_afr.loc[assocs_afr["Region"] == gene]["Pvalue"])), color="red",s=10)
	#ax.scatter(-math.log(p), assocs_meta.loc[assocs_sas["Region"] == gene]["Pvalue_SKAT"], label="SAS",s=10)

ax.axline((0, 0), slope=1)
ax.set_aspect('equal', adjustable='box')

ax.legend()

plt.show()
