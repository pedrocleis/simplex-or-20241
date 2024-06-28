import pulp

# Define the problem
prob = pulp.LpProblem("TransshipmentProblem", pulp.LpMinimize)

# Sets
nodes = ['M1', 'M2', 'M3', 'M4', 'M5', 'H1', 'H2', 'H3', 'H4', 'H5', 'L1', 'L2', 'L3', 'L4', 'L5']
supply_nodes = ['M1', 'M2', 'M3', 'M4', 'M5']
transshipment_nodes = ['H1', 'H2', 'H3', 'H4', 'H5']
demand_nodes = ['L1', 'L2', 'L3', 'L4', 'L5']

# Parameters (example data)
costs = {
    ('M1', 'H1'): 4, ('M1', 'H2'): 6, ('M1', 'H3'): 8, ('M1', 'H4'): 7, ('M1', 'H5'): 9,
    ('M2', 'H1'): 5, ('M2', 'H2'): 7, ('M2', 'H3'): 9, ('M2', 'H4'): 6, ('M2', 'H5'): 8,
    ('M3', 'H1'): 3, ('M3', 'H2'): 4, ('M3', 'H3'): 5, ('M3', 'H4'): 7, ('M3', 'H5'): 6,
    ('M4', 'H1'): 6, ('M4', 'H2'): 5, ('M4', 'H3'): 7, ('M4', 'H4'): 8, ('M4', 'H5'): 9,
    ('M5', 'H1'): 7, ('M5', 'H2'): 8, ('M5', 'H3'): 9, ('M5', 'H4'): 6, ('M5', 'H5'): 5,
    ('H1', 'L1'): 2, ('H1', 'L2'): 3, ('H1', 'L3'): 6, ('H1', 'L4'): 5, ('H1', 'L5'): 4,
    ('H2', 'L1'): 4, ('H2', 'L2'): 2, ('H2', 'L3'): 7, ('H2', 'L4'): 6, ('H2', 'L5'): 3,
    ('H3', 'L1'): 5, ('H3', 'L2'): 3, ('H3', 'L3'): 2, ('H3', 'L4'): 7, ('H3', 'L5'): 6,
    ('H4', 'L1'): 6, ('H4', 'L2'): 5, ('H4', 'L3'): 3, ('H4', 'L4'): 4, ('H4', 'L5'): 2,
    ('H5', 'L1'): 7, ('H5', 'L2'): 6, ('H5', 'L3'): 4, ('H5', 'L4'): 3, ('H5', 'L5'): 2
}
supplies = {'M1': 20, 'M2': 30, 'M3': 25, 'M4': 35, 'M5': 40}
demands = {'L1': 25, 'L2': 30, 'L3': 20, 'L4': 35, 'L5': 30}
capacities = {
    ('M1', 'H1'): 15, ('M1', 'H2'): 20, ('M1', 'H3'): 10, ('M1', 'H4'): 25, ('M1', 'H5'): 20,
    ('M2', 'H1'): 20, ('M2', 'H2'): 25, ('M2', 'H3'): 15, ('M2', 'H4'): 30, ('M2', 'H5'): 25,
    ('M3', 'H1'): 10, ('M3', 'H2'): 20, ('M3', 'H3'): 30, ('M3', 'H4'): 25, ('M3', 'H5'): 20,
    ('M4', 'H1'): 25, ('M4', 'H2'): 30, ('M4', 'H3'): 20, ('M4', 'H4'): 15, ('M4', 'H5'): 10,
    ('M5', 'H1'): 20, ('M5', 'H2'): 25, ('M5', 'H3'): 15, ('M5', 'H4'): 20, ('M5', 'H5'): 30,
    ('H1', 'L1'): 10, ('H1', 'L2'): 20, ('H1', 'L3'): 15, ('H1', 'L4'): 25, ('H1', 'L5'): 20,
    ('H2', 'L1'): 25, ('H2', 'L2'): 30, ('H2', 'L3'): 20, ('H2', 'L4'): 15, ('H2', 'L5'): 10,
    ('H3', 'L1'): 20, ('H3', 'L2'): 15, ('H3', 'L3'): 25, ('H3', 'L4'): 20, ('H3', 'L5'): 30,
    ('H4', 'L1'): 15, ('H4', 'L2'): 20, ('H4', 'L3'): 30, ('H4', 'L4'): 25, ('H4', 'L5'): 20,
    ('H5', 'L1'): 20, ('H5', 'L2'): 25, ('H5', 'L3'): 15, ('H5', 'L4'): 30, ('H5', 'L5'): 20
}

# Decision variables
x = pulp.LpVariable.dicts("x", [(i, j) for i in nodes for j in nodes], lowBound=0, cat='Continuous')

# Objective function
prob += pulp.lpSum(costs[i, j] * x[i, j] for i, j in costs)

# Constraints
# Supply constraints
for i in supply_nodes:
    prob += pulp.lpSum(x[i, j] for j in nodes if (i, j) in costs) <= supplies[i]

# Demand constraints
for j in demand_nodes:
    prob += pulp.lpSum(x[i, j] for i in nodes if (i, j) in costs) >= demands[j]

# Flow conservation constraints
for k in transshipment_nodes:
    prob += pulp.lpSum(x[i, k] for i in nodes if (i, k) in costs) == pulp.lpSum(x[k, j] for j in nodes if (k, j) in costs)

# Capacity constraints
for (i, j) in capacities:
    prob += x[i, j] <= capacities[i, j]

# Solve the problem
prob.solve()

# Print the results
for v in prob.variables():
    if v.varValue > 0:
        print(f"{v.name} = {v.varValue}")

print(f"Total cost = {pulp.value(prob.objective)}")
