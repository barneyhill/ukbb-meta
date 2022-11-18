import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import math

chr20 = pd.read_csv("07_10_data/associations_output_chr20.txt", sep=' ')
chr21 = pd.read_csv("07_10_data/associations_output_chr21.txt", sep=' ')

fig, ax = plt.subplots()
#ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(chr20["Pval"])+1)[1:]],
#           [-math.log(p) for p in chr20["Pval"].sort_values()], label="AFR/EUR/SAS meta-analysis (chromosome 20)")

#ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(chr21["Pval"])+1)[1:]],
#           [-math.log(p) for p in chr21["Pval"].sort_values()], label="AFR/EUR/SAS meta-analysis (chromosome 21)")

print(chr20["Pval"])
print(chr21["Pval"])

print(len(chr20["Pval"])+len(chr21["Pval"])+1)
print(len(pd.concat([chr20["Pval"], chr21["Pval"]])))

ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(chr20["Pval"])+len(chr21["Pval"])+1)[1:]],
           [-math.log(p) for p in pd.concat([chr20["Pval"], chr21["Pval"]]).sort_values()], label="AFR/EUR/SAS meta-analysis (chromosome 20+21)")

#ax.hist(pd.concat([chr20["Pval"], chr21["Pval"]]))

ax.axline((0, 0), slope=1)
ax.legend()

plt.show()
