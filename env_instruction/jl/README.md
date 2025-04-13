# Julia

# How to install Julia?
Please check the [official website.](https://julialang.org/downloads/)

Please use [Juliaup](https://github.com/JuliaLang/juliaup), a Julia installer and version multiplexer.

```sh
# Windows
> winget install julia -s msstore

# macOS or Linux
$ curl curl -fsSL https://install.julialang.org | sh

# homebrew (MacOS)
$ brew install juliaup
```

Then, run
```sh
juliaup add <version>
```
to install a specific version of Julia. *e.g.* ```juliaup add 1.10```


# How to install packages?
Open the terminal, and run ```julia```. Interactive command line **REPL** is launched.

```sh
$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.10.3 (2024-04-30)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```
Then, press ```]``` and run the following command to install a package.
```sh
$ (@v1.10) pkg> add <packagename>
```
*e.g.* ```add PyPlot```

# Export environment

