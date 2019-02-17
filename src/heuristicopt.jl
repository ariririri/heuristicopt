
__precompile__()

module heuristicopt

export GA, GATool

module GA
include("ga/ga.jl")
export GAFunction, GAParameter
end

module GATool
include("ga/crossover.jl")
include("ga/elite.jl")
include("ga/mutate.jl")
include("ga/select.jl")
end

end # heruristing opt end
