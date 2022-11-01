import sys
import pandas as pd
import matplotlib.pyplot as plt
import math
import numpy as np

assocs_meta = pd.read_csv(sys.argv[1], sep=' ')
assocs_afr = pd.read_csv(sys.argv[2], sep='\t')
assocs_sas = pd.read_csv(sys.argv[3], sep='\t')



fig, ax = plt.subplots()

ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs_meta["Pval"])+1)[1:]],
           [-math.log(p) for p in assocs_meta["Pval"].sort_values()], label="META",s=10)
ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs_afr["Pvalue_SKAT"])+1)[1:]],
           [-math.log(p) for p in assocs_afr["Pvalue"].sort_values()], label="AFR",s=10)
ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs_sas["Pvalue_SKAT"])+1)[1:]],
           [-math.log(p) for p in assocs_sas["Pvalue"].sort_values()], label="SAS",s=10)

ax.axline((0, 0), slope=1)
ax.set_aspect('equal', adjustable='box')

ax.legend()

plt.show()
