using heuristicopt

function main()
    population = reshape(rand(1:10, 100), (10, 10))
    crossoverRate = 0.5
    mutationRate = 0.1
    iterations = 100
    gaparam = GA.GAParameter(
                         crossoverRate,
                         mutationRate,
                         iterations
                         )

    select = GATool.selectrandom
    crossover = GATool.crossoverOne
    mutate = GATool.mutaterandom
    gafunc = GA.GAFunction(select, crossover, mutate)
    model = GA.GAModel(
        gaparam,
        gafunc,
        objfunc
    )
    predictPopulation, bestFitness = GA.predict(model, population)
    print("bestFitness", bestFitness)
end

function objfunc(individual)
    0
end

main()
