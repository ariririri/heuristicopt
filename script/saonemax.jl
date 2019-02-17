using heuristicopt

function main()
    # obj supports only maximazation
    initsate = rand(0:1, 100)
    tmin = 10
    tmax = 10000
    steps = 10000
    param = SA.SAParameter(tmin, tmax, steps)
    model = SA.SAModel(param, move, objfunc)
    besttrial = SA.predict(model, initsate)
    print("best fitness is ", besttrial.energy)
    print("best paramaeter is ", besttrial.state)
end

function move(array)
    N = length(array)
    point = rand(1:N)
    array[point] = 1 - array[point]
    return array
end

function objfunc(array)
    sum(array) * length(array)
end

main()
