import numpy as np
from scipy.optimize import linprog

c = [0, 0, 0, -1]  # p1, p2, p3, z

A_ub = [[0, 1, -1, 1], [-1, 0, 1, 1], [1, -1, 0, 1]]
b_ub = [0, 0, 0]

# p1 + p2 + p3 = 1
A_eq = [[1, 1, 1, 0]]
b_eq = [1]

# p1, p2, p3 >= 0
# z in R
bounds = [(0, None), (0, None), (0, None), (None, None)]

res = linprog(
    c, A_ub=A_ub, b_ub=b_ub, A_eq=A_eq, b_eq=b_eq, bounds=bounds, method="highs"
)

if res.success:
    print(f"p1 (Stein):  {res.x[0]:.3f}")
    print(f"p2 (Schere): {res.x[1]:.3f}")
    print(f"p3 (Papier): {res.x[2]:.3f}")
    print(f"Spielwert z: {res.x[3]:.3f}")
else:
    print("Fehler:", res.message)
