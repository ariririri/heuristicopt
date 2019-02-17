# load
include("crossover.jl")
include("elite.jl")
include("select.jl")
include("mutate.jl")

using Random


mutable struct GAParameter
    #popilationSize
    #lowerBounds
    #upperBounds
    crossoverRate::Float64
    mutationRate::Float64
    #N::Int = 1
    iterations::Integer
    #e::Real = 0
end

mutable struct GAFunction
    select::Function
    crossover::Function
    mutate::Function
end

mutable struct GAmodel
    GAParameter::GAParameter
    GAFunction::GAFunction
    objFunction::Function
end

function predict(GAmodel,population
    )
    populationSize = size(population, 1)
    geneSize = size(population, 2)

    bestIndividual = population[1]
    bestloss = Inf32

    for _ in  1:GAmodel.GAParameter.iterations
        println("start select")
        selected = GAmodel.GAFunction.select(population)

        # matingのパラメータ;matingのメソッドはcrossover
        println("start crossover")
        offspring = reshape(zeros(length(population)), (populationSize, geneSize))
        for i in 1:div(populationSize, 2)
            offspring[2 * i - 1, :], offspring[2 * i, :] = GAmodel.GAFunction.crossover(selected[2 * i - 1,:], selected[2 * i,:])
        end

        # mutate
        println("start mutate")
        fitness = zeros(populationSize)
        for i in 1:populationSize
            population[i,:] = GAmodel.GAFunction.mutate(offspring[i,:], GAmodel.GAParameter.mutationRate)
            fitness[i] = GAmodel.objFunction(population[i,:])
        end

        # elitism
        # TODO
        println("no elite")

        fitidx = sortperm(fitness, rev=true)
        _bestIndividual = population[fitidx[1]]
        _bestloss = fitness[fitidx[1]]
        if bestloss > _bestloss
            bestIndividual = _bestIndividual
            bestloss = _bestloss
        end

    end
    print("bestFitness", bestloss)
    return bestIndividual, bestloss
end

function fit!(GAmodel, X, y
    )
    println("gene aligorithm needs no train")
    return GAmodel
end


# 0 means tobe late
function main()
    individuals = reshape(rand(1:10, 100), (10, 10))
    population = individuals
    crossoverRate = 0.5
    mutationRate = 0.1
    iterations = 100
    gaparam = GAParameter(
                         crossoverRate,
                         mutationRate,
                         iterations
                         )
    gafunc = GAFunction(selectrandom,crossoverOne,mutaterandom)
    model = GAmodel(
        gaparam,
        gafunc,
        objfunc
    )
    predict(model, population)
end

function objfunc(individual)
    0
end




main()
