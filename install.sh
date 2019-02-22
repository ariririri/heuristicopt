#!/bin/sh

julia <<EOF
using Pkg
Pkg.add(PackageSpec(url = "https://github.com/ariririri/heuristicopt.jl"))
EOF
