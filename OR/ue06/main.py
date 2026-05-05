import numpy as np
import pandas as pd
import scipy.optimize as opt

# Read edge weights into cost matrix
df = pd.read_csv("Verkehrsnetz.csv", sep=";", index_col=0)
c = df.to_numpy(dtype=float)
c = np.nan_to_num(c, nan=np.inf)

s, t = np.asarray(c != np.inf).nonzero()

c1d = c[s, t]

n_nodes = c.shape[0]
n_edges = len(c1d)

# Nebenbedingung
A_eq = np.zeros((n_nodes, n_edges))
A_eq[s, np.arange(n_edges)] = 1
A_eq[t, np.arange(n_edges)] = -1
# b_eq = np.array([1, 0, -1])
b_eq = np.zeros(n_nodes)
b_eq[0] = 1
b_eq[-1] = -1

print(A_eq)
print(b_eq)

res = opt.linprog(c1d, A_eq=A_eq, b_eq=b_eq, bounds=(0, 1))

for k in range(n_edges):
    if round(res.x[k]) == 1:
        print(f"Take edge {s[k]} -> {t[k]} (Cost: {c1d[k]})")

# TODO fix, this is broken
