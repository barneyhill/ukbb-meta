import sys
import pandas as pd
import matplotlib.pyplot as plt
import math
import numpy as np

assocs_afr = pd.read_csv("07_10_data/saige/AFR_associations.txt", sep='\t')
assocs_sas = pd.read_csv("07_10_data/saige/SAS_associations.txt", sep='\t')
assocs_eur = pd.read_csv("07_10_data/saige/EUR_associations.txt", sep='\t')

fig, ax = plt.subplots()

print(assocs_afr, assocs_sas, assocs_eur)

ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs_afr["p.value"])+1)[1:]],
           [-math.log(p) for p in assocs_afr["p.value"].sort_values()], label="AFR",s=10)

ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs_sas["p.value"])+1)[1:]],
           [-math.log(p) for p in assocs_sas["p.value"].sort_values()], label="SAS",s=10)

ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs_eur["p.value"])+1)[1:]],
           [-math.log(p) for p in assocs_eur["p.value"].sort_values()], label="EUR",s=10)

ax.axline((0, 0), slope=1)
ax.set_aspect('equal', adjustable='box')

ax.legend()

plt.show()
