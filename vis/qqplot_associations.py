import sys
import pandas as pd
import matplotlib.pyplot as plt
import math
import numpy as np
assocs = pd.read_csv(sys.argv[1], sep='\t')


fig, ax = plt.subplots()
ax.scatter([-math.log(p) for p in np.linspace(0, 1, num=len(assocs["p.value"])+1)[1:]],
           [-math.log(p) for p in assocs["p.value"].sort_values()])

ax.axline((0, 0), slope=1)


plt.show()
