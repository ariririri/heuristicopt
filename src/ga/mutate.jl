
function mutaterandom(individual, mutationRate)
    if rand() < mutationRate
        s = size(individual, 1)
        mutatepoints = rand(1:s,2)
        individual[mutatepoints[1]], individual[mutatepoints[2]] = individual[mutatepoints[2]], individual[mutatepoints[1]]
    end
    return individual
end
