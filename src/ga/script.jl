include("ga.jl")
include("select.jl")
include("mutate.jl")
include("crossover.jl")
inclued("funcconfig.jl")
using heuristicopt


import JSON

function main()
    # init population
    # 本当はindividuakは入力に受け取って、それを扁壷する
    individuals = reshape(rand(1:10, 100), (10, 10))
    population = individuals

    # parameter
    param = load_params()
    gaparam = GA.GAParameter(population,
                             param["crossoverRate"],
                             param["mutationRate"],
                             param["iterations"]
                             )

    # どうやってselect,crossover,mutateを選ばせるか
    # 設計が崩壊 一回決めればいいが、hyperparameter turningで動かしたい
    select = eval(funcconfig.select)
    crossover = eval(funcconfig.crossover)
    mutate = eval(funcconfig.mutate)

    GA.ga(
        population,
        gaparam,
        select,
        crossover,
        mutate,
        objfunc
    )
end

function funcselect(params)
    print("tobelater")
end

function load_params(path="config.json")
    open("config.json", "r") do f
        global params
        dicttxt = readall(f)  # file information to string
        param = JSON.parse(dicttxt)  # parse and transform data
    end
    return param
end


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
    gafunc = GAFunction(selectrandom,
                        crossoverOne,
                        mutaterandom
                        )
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
