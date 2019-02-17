#!/bin/sh

julia <<EOF
using Pkg
Pkg.clone("https://github.com/ariririri/heuristicopt.jl")
EOF
