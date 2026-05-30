import numpy as np
from scipy.optimize import linprog

# Variablen-Index: 0=p1, 1=p2, 2=p3, 3=z
# Zielfunktion: min -z
c = [0, 0, 0, -1]

# Ungleichungen (A_ub * x <= b_ub)
# 1. z + p2 - p3 <= 0
# 2. z - p1 + p3 <= 0
# 3. z + p1 - p2 <= 0
A_ub = [[0, 1, -1, 1], [-1, 0, 1, 1], [1, -1, 0, 1]]
b_ub = [0, 0, 0]

# Gleichungen (A_eq * x == b_eq)
# p1 + p2 + p3 = 1
A_eq = [[1, 1, 1, 0]]
b_eq = [1]

# Grenzen (bounds)
# p1, p2, p3 >= 0
# z in R (unbeschränkt)
bounds = [(0, None), (0, None), (0, None), (None, None)]

# Optimierung starten
res = linprog(
    c, A_ub=A_ub, b_ub=b_ub, A_eq=A_eq, b_eq=b_eq, bounds=bounds, method="highs"
)

# Ausgabe
if res.success:
    print(f"p1 (Stein):  {res.x[0]:.3f}")
    print(f"p2 (Schere): {res.x[1]:.3f}")
    print(f"p3 (Papier): {res.x[2]:.3f}")
    print(f"Spielwert z: {res.x[3]:.3f}")
else:
    print("Fehler:", res.message)
