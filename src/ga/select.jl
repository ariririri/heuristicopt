using Random

function selectrandom(array, fitness)
    # fitness is not necessarly
    # 引数を合わせるため
    array = shuffle(array)
    return array
end

function selectroulette(array, fitness)
    populationSize = size(array, 1)
    geneSize = size(array, 2)
    prob = fitness./ sum(fitness)

    selectedIndex = pselection(prob, populationSize)
    # Intに限定
    selected = reshape(zeros(Int, length(array)), (populationSize, geneSize))
    for (i, j) in enumerate(selectedIndex)
        selected[i, :] = array[j, :]
    end
    return selected
end


# probability selection
function pselection(prob::Vector{Float64}, N::Int)
    cp = cumsum(prob)
    selected = Array{Int}(undef, N)
    for i in 1:N
        j = 1
        r = rand()
        while cp[j] < r
            j += 1
        end
        selected[i] = j
    end
    return selected
end
