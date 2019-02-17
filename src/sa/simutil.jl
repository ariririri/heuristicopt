function init(init_state, energy)
    init_energy = energy(init_state)
    init_trial = Trial(init_state, init_energy)
    return init_trial, init_trial
end

function anneal_one(now_trial, move, energy)
    prev_trial = deepcopy(now_trial)
    now_state = move(now_trial.state)
    now_energy = energy(now_state)
    now_trial = Trial(now_state, now_energy)
    return now_trial, prev_trial
end

function check_state_update(now_trial, prev_trial, t)
    # diff_energy > 0 は劣化
    diff_energy = prev_trial.energy - now_trial.energy
    uniform = Distributions.Uniform(0, 1)
    if diff_energy > 0.0 && exp(- diff_energy / t) < rand(uniform)
        return false
    else
        return true
    end
end

function update(now_trial, prev_trial, best_trial)
    if best_trial.energy <= now_trial.energy
        best_trial = deepcopy(now_trial)
    end
    return now_trial, best_trial
end


function move(state)
    # need original function
    return  state
end

function energy(state)
    # need original function
    return  sum(state)
end
