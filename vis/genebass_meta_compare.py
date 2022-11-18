import sys
import pandas as pd
import matplotlib.pyplot as plt
import math
import numpy as np

chr20 = pd.read_csv("07_10_data/associations_output_chr20.txt", sep=' ')
chr21 = pd.read_csv("07_10_data/associations_output_chr21.txt", sep=' ')
gene_bass = pd.read_csv("T2D_EUR_genebass.csv", sep=",")

meta = pd.concat([chr20, chr21])

print(meta)

print(gene_bass)

gene_list = list(set(gene_bass["Gene Name"]) & set(meta["GENE"]))

print(len(gene_list))

#assocs_afr = assocs_afr.loc[assocs_afr["Region"].isin(gene_list)] 
#assocs_sas = assocs_sas.loc[assocs_sas["Region"].isin(gene_list)]

fig, ax = plt.subplots()

print(len(meta))

for gene in gene_list:
	#print(meta.loc[meta["GENE"] == gene],gene_bass.loc[gene_bass["Gene Name"] == gene])
	ax.scatter(-math.log10(float(meta.loc[meta["GENE"] == gene]["Pval"])),
		       -math.log10(float(gene_bass.loc[gene_bass["Gene Name"] == gene]["P‑Value SKATO"])), color="red")
	#print(gene,p,assocs_meta[assocs_meta["GENE"] == gene]["Pval"], assocs_afr[assocs_afr["Region"] == gene]["Pvalue_SKAT"],assocs_sas[assocs_sas["Region"] == gene]["Pvalue_SKAT"])
	#ax.scatter(-math.log(p), -math.log(float(assocs_meta.loc[assocs_meta["GENE"] == gene]["Pval"])), color="blue",s=10)
	#ax.scatter(-math.log(p), -math.log(float(assocs_afr.loc[assocs_afr["Region"] == gene]["Pvalue"])), color="red",s=10)
	#ax.scatter(-math.log(p), assocs_meta.loc[assocs_sas["Region"] == gene]["Pvalue_SKAT"], label="SAS",s=10)

ax.set_xlabel("Meta-analysis Pvalue")
ax.set_ylabel("Genebass SKAT-O Pvalue")
ax.axline((0, 0), slope=1)
ax.set_aspect('equal', adjustable='box')

ax.legend()

plt.show()
