# exempleJumpExplicite.jl

using JuMP, GLPK, Printf

const s1 = 25.0   # speed of the taxi
const s2 = 20.0   # speed of the bus
const s3 = 15.0   # speed of the shared bike
const s4 = 4.5    # speed of the walk

const c1 = 60     # cost of the taxi per hour
const c2 = 0.5    # cost of the bus per hour
const c3 = 0.3    # cost of the shared bike per hour
const c4 = 0      # cost of the walk per hour

# -----------------------------------------------------------------------------

m = Model(GLPK.Optimizer)

@variable(m, x1 >= 0)      # travel time / taxi
@variable(m, x2 >= 0)      # travel time / bus
@variable(m, x3 >= 0)      # travel time / bicycle 
@variable(m, x4 >= 0)      # travel time / walking

@variable(m, n2 >= 0, Int) # number of segments by bus
@variable(m, n3 >= 0, Int) # number of segments by bicycle

@objective(m, Min, c1*x1 + c2*x2 + c3*x3 + c4*x4)       # total cost for the journey

@constraint(m, x1 + x2 + x3 + x4 <= 1)                  # max 1 hour
@constraint(m, x1 + x2 <= 0.75)                         # max 45min by (taxi+bus)
@constraint(m, x1*s1 + x2*s2 + x3*s3 + x4*s4 >= 13)     # distance airport-home
@constraint(m, x1*s1 + x2*s2 + x3*s3 + x4*s4 <= 17)     # upper bound (?? je comprends pas cette contrainte)

@constraint(m, 0.5 * n2 /s2 == x2) # travel time by bus
@constraint(m, 1.0 * n3 /s3 == x3) # travel time by bicycle

# -----------------------------------------------------------------------------

optimize!(m)

# -----------------------------------------------------------------------------

println("")
print(m)
println("")

@show termination_status(m)
print(" z = ",objective_value(m)," € \n") 

@printf("x1 = %3.2f  -> %2d min / taxi    \n", value(x1), floor(Int, value(x1)*60))
@printf("x2 = %3.2f  -> %2d min / bus     \n", value(x2), floor(Int, value(x2)*60))
@printf("x3 = %3.2f  -> %2d min / bicycle \n", value(x3), floor(Int, value(x3)*60))
@printf("x4 = %3.2f  -> %2d min / foot    \n", value(x4), floor(Int, value(x4)*60))
println(" ")

print("n2 = ",floor(Int,value(n2))," segments by bus\n")
print("n3 = ",floor(Int,value(n3))," segments by bicycle\n")
println(" ")

println("That's all folks --------------------------------------")

