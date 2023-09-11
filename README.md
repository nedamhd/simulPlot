# simulPlot
An overview plot for Monte Carlo simulation studies.
## Installation: Run the code for installing:
`devtools::install_github("nedamhd/simulPlot")`

## Example
#### Generating Artificial Data
` n = c(500, 1000, 5000) 
**
**
DGP = c(1:4)
 lambda = c(0.25, 0.5, 0.75)
 methods = c(letters[1:5])
 data = expand.grid(
      n = n,
      DGP = DGP,
      lambda = lambda,
     methods = methods
   )
  data$bias = rnorm(dim(data)[1])
  data$rmse = runif(dim(data)[1])`
  #### Draw the Plot
 ` simlationPlot (
    data,
    parameters = ~ n:DGP:lambda,
   methods = "methods",
    bias = "bias",
    rmse = "rmse"
  )`
