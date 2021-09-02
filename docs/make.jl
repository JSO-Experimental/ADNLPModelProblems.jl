using Documenter, ADNLPModelProblems

makedocs(
  modules = [ADNLPModelProblems],
  doctest = true,
  # linkcheck = true,
  strict = true,
  format = Documenter.HTML(
    assets = ["assets/style.css"],
    prettyurls = get(ENV, "CI", nothing) == "true",
  ),
  sitename = "ADNLPModelProblems",
  pages = Any["Home" => "index.md", "Tutorial" => "tutorial.md", "Reference" => "reference.md"],
)

deploydocs(
  repo = "github.com/tmigot/ADNLPModelProblems.git",
  devbranch = "main",
)
