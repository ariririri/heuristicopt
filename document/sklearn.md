# Sklearn

Pythonでは機械学習のデファクトとしてsklearnがある.
JuliaらしくかつSklearnのように書くのはどうするべきか。


Juliaはfunctionが重要なので、Sklearn.jlを見てもfunctionの引数にモデル,データとしている。
例えば以下。


```julia
import ScikitLearnBase

type NaiveBayes
    # The model hyperparameters (not learned from data)
    bias::Float64

    # The parameters learned from data
    counts::Matrix{Int}

    # A constructor that accepts the hyperparameters as keyword arguments
    # with sensible defaults
    NaiveBayes(; bias=0.0f0) = new(bias)
end

# This will define `clone`, `set_params!` and `get_params` for the model
ScikitLearnBase.@declare_hyperparameters(NaiveBayes, [:bias])

# NaiveBayes is a classifier
ScikitLearnBase.is_classifier(::NaiveBayes) = true   # not required for transformers

function ScikitLearnBase.fit!(model::NaiveBayes, X, y)
    # X should be of size (n_sample, n_feature)
    .... # modify model.counts here
    return model
end

function ScikitLearnBase.predict(model::NaiveBayes, X)
    .... # returns a vector of predicted classes here
end
```
これを中心に記述する。
