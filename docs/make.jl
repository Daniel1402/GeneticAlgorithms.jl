using GeneticAlgorithms
using Documenter

DocMeta.setdocmeta!(GeneticAlgorithms, :DocTestSetup, :(using GeneticAlgorithms); recursive=true)

makedocs(;
    modules=[GeneticAlgorithms],
    authors="Daniel Kirste <daniel.kirste@campus.tu-berlin.de>",
    sitename="GeneticAlgorithms.jl",
    format=Documenter.HTML(;
        canonical="https://Daniel1402.github.io/GeneticAlgorithms.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Daniel1402/GeneticAlgorithms.jl",
    devbranch="main",
)
