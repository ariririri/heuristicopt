using heuristicopt

function main()
    # 50 individual , 100 gene
    population = rand(0:1, 50, 100)
    crossoverRate = 0.5
    mutationRate = 0.1
    iterations = 10000
    gaparam = GA.GAParameter(
                         crossoverRate,
                         mutationRate,
                         iterations
                         )

    select = GATool.selectroulette
    crossover = GATool.crossoverone
    mutate = GATool.mutaterandom
    gafunc = GA.GAFunction(select, crossover, mutate)
    model = GA.GAModel(
        gaparam,
        gafunc,
        objfunc
    )
    predictPopulation, bestFitness = GA.predict(model, population)
    print("bestFitness", bestFitness)
    print(predictPopulation)
end

function objfunc(individual)
    sum(individual)
end

main()
