from ortools.linear_solver import pywraplp

solver: pywraplp.Solver = pywraplp.Solver.CreateSolver("SAT")

if not solver:
    exit(1)

infinity = solver.infinity()
x1 = solver.IntVar(0, 2, "x1")
x2 = solver.IntVar(0, 2, "x2")
x3 = solver.IntVar(0, 2, "x3")
x4 = solver.IntVar(0, 2, "x4")
x5 = solver.IntVar(0, 2, "x5")

solver.Add(5 * x1 + 4 * x2 + 2 * x3 + 2 * x4 + 2 * x5 <= 15)

solver.Maximize(3 * x1 + 6 * x2 + 6 * x3 + 8 * x4 + 1 * x5)

status = solver.Solve()

if status == pywraplp.Solver.OPTIMAL:
    print("Solution:")
    print("Objective value =", solver.Objective().Value())
    print(
        f"x1={x1.solution_value()} x2={x2.solution_value()} x3={x3.solution_value()} x4={x4.solution_value()}"
    )
else:
    print("The problem does not have an optimal solution.")
