import numpy as np
from scipy.optimize import linprog

c = np.array([-2000, -3000])
b_ub = np.array([180, 135])
A_ub = np.array([[3, 5], [3, 3]])

res = linprog(c=c, b_ub=b_ub, A_ub=A_ub)

print(f"result:\n{res}")
