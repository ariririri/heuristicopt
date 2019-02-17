# load
include("crossover.jl")
include("elite.jl")
include("select.jl")
include("mutate.jl")

using Random


mutable struct GAParameter
    #lowerBounds
    #upperBounds
    crossoverRate::Float64
    mutationRate::Float64
    iterations::Integer
end

mutable struct GAFunction
    select::Function
    crossover::Function
    mutate::Function
end

mutable struct GAModel
    GAParameter::GAParameter
    GAFunction::GAFunction
    objfunction::Function
end

function predict(GAModel, population
    )
    populationSize = size(population, 1)
    geneSize = size(population, 2)

    bestIndividual = population[1]
    bestfit = 0
    fitness = zeros(populationSize)

    for i in 1:populationSize
        fitness[i] = GAModel.objfunction(population[i])
    end

    for iter in  1:GAModel.GAParameter.iterations
        # select
        selected = GAModel.GAFunction.select(population, fitness)

        # crossover
        offspring = reshape(zeros(length(population)), (populationSize, geneSize))
        for i in 1:div(populationSize, 2)
            offspring[2 * i - 1, :], offspring[2 * i, :] = GAModel.GAFunction.crossover(selected[2 * i - 1,:], selected[2 * i,:])
        end

        # mutate
        for i in 1:populationSize
            population[i,:] = GAModel.GAFunction.mutate(offspring[i,:], GAModel.GAParameter.mutationRate)
            fitness[i] = GAModel.objfunction(population[i,:])
        end

        # elitism
        # TODO

        fitidx = sortperm(fitness, rev=true)
        _bestIndividual = population[fitidx[1]]
        _bestfit = fitness[fitidx[1]]
        if bestfit < _bestfit
            bestIndividual = _bestIndividual
            bestfit = _bestfit
        end

        if iter % 50 == 0
            print("iter ", iter)
            println(" bestfit ", bestfit)
            println("bestIndividual", bestIndividual)
        end

    end
    print("bestFitness", bestfit)
    return bestIndividual, bestfit
end

function fit!(GAModel, X, y
    )
    println("gene aligorithm needs no train")
    return GAModel
end
