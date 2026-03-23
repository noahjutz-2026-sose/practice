from ortools.linear_solver import pywraplp

solver: pywraplp.Solver = pywraplp.Solver.CreateSolver("GLOP")
if not solver:
    exit(1)

inf = solver.infinity()

x1 = solver.NumVar(0, inf, "x1")
x2 = solver.NumVar(0, inf, "x2")

constraint1: pywraplp.Constraint = solver.Constraint(0, 180, "ct1")
constraint1.SetCoefficient(x1, 3)
constraint1.SetCoefficient(x2, 5)

constraint2: pywraplp.Constraint = solver.Constraint(0, 135, "ct2")
constraint2.SetCoefficient(x1, 3)
constraint2.SetCoefficient(x2, 3)

objective: pywraplp.Objective = solver.Objective()
objective.SetCoefficient(x1, 1)
objective.SetCoefficient(x2, 1)
objective.SetMaximization()

print(f"Solving with {solver.SolverVersion()}")
result_status = solver.Solve()
print(f"Status: {result_status}")
if result_status != pywraplp.Solver.OPTIMAL:
    print("The problem does not have an optimal solution!")
    if result_status == pywraplp.Solver.FEASIBLE:
        print("A potentially suboptimal solution was found")
    else:
        print("The solver could not solve the problem.")
        exit(2)

print("Solution:")
print("Objective value =", objective.Value())
print("x1 =", x1.solution_value())
print("x2 =", x2.solution_value())
