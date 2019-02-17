using Distributions

include("simutil.jl")


struct SAParameter
    tmin
    tmax
    steps
end


mutable struct SAModel
    SAParameter::SAParameter
    move::Function
    energy::Function # energy function
end

mutable struct Trial
    state
    energy::Float32
end

function fit!(SAModel, X, y)
    println("Simulated Annealing needs not to train")
    SAModel
end

function predict(
    SAModel,
    initstate,
    )

    tfactor = - log(SAModel.SAParameter.tmax / SAModel.SAParameter.tmin)
    nowtrial, besttrial = init(initstate, SAModel.energy)
    for step in 1:SAModel.SAParameter.steps
        t = SAModel.SAParameter.tmax * exp(tfactor * step / SAModel.SAParameter.steps)
        nowtrial, prevtrial = anneal_one(nowtrial, SAModel.move, SAModel.energy)
        if check_state_update(nowtrial, prevtrial, t)
            nowtrial, besttrial = update(nowtrial, prevtrial, besttrial)
        else
            nowtrial = prevtrial
        end

        if step % 1000 == 0
            println("step is over ", step)
            println("best energy is ", besttrial.energy)
        end
    end

    println("step is end")
    println("best energy is ", besttrial.energy)
    println("best state is ", besttrial.state)
    return besttrial
end
