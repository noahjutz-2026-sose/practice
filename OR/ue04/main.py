from ortools.linear_solver import pywraplp

solver: pywraplp.Solver = pywraplp.Solver.CreateSolver("SAT")

infinity = solver.infinity()
x1 = solver.NumVar(0, infinity, "x1")
x2 = solver.NumVar(0, infinity, "x2")

solver.Add(5 * x1 + 9 * x2 <= 54)
solver.Add(7 * x1 - 8 * x2 <= 14)

# Branch: x1 <= 5
solver.Add(x1 <= 5)

solver.Maximize(7 * x1 + 10 * x2)

status = solver.Solve()

if status != pywraplp.Solver.OPTIMAL:
    print(f"Not optimal: {status}")
    exit(1)

print(solver.Objective().Value())
print(x1.solution_value())
print(x2.solution_value())
