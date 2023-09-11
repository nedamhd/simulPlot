# simulPlot
An overview plot for Monte Carlo simulation studies.
## Installation: Run the code for installing:
`devtools::install_github("nedamhd/simulPlot")`

## Example
#### Generating Artificial Data
```{r}
n = c(500, 1000)
DGP = c(1:4)
lambda = c(0.25, 0.5, 0.75)
methods = c(letters[1:5])
data = expand.grid(
  n = n,
  DGP = DGP,
  lambda = lambda,
  methods = methods
)
data$n=factor(data$n,levels = c(500, 1000),labels = 
                 c("n = 500", 1000))
data$lambda=factor(data$lambda,levels = c(0.25, 0.5, 0.75),labels = 
                c("lambda = 25",  50, 75))
data$DGP=factor(data$DGP,levels = c(1:4),labels = 
                c("DGP = 1", 2,3,4))

data$bias = rnorm(dim(data)[1])
data$rmse = runif(dim(data)[1])

```  
  #### Draw the Plot
  
```{r, data}
simulPlot::simulationPlot (  
    data,  
    parameters = ~ n:DGP:lambda,  
   methods = "methods",  
    bias = "bias",  
    rmse = "rmse"  
  )
```


![plot](https://github.com/nedamhd/simulPlot/assets/38834367/99f41a0e-2a44-4ba2-a938-2a3f04dfe8b5)
