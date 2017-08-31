# RLumModel Shiny

[![Build Status](https://travis-ci.org/JohannesFriedrich/rxylibShiny.svg?branch=master)](https://travis-ci.org/JohannesFriedrich/rxylibShiny)
[![Build status](https://ci.appveyor.com/api/projects/status/tciywrm10kn43n1g?svg=true)](https://ci.appveyor.com/project/JohannesFriedrich/rxylibshiny)


'RLumModel Shiny' is a [Shiny](http://shiny.rstudio.com) app providing a graphical user interface for the **R** package ['RLumModel'](https://CRAN.R-project.org/package=RLumModel). The app allows visualising the results from simulating charge transfer in quartz.

## Installation and usage

```{r}
if(!require("devtools"))
  install.packages("devtools")
devtools::install_github("JohannesFriedrich/RLumModelShiny@master")
```

The application can be run on a local machine with the following command:

```r
RLumModelShiny::run_RLumModel()
```

## License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
