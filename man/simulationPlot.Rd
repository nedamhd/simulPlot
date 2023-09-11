
\name{simulPlot}
\alias{simulPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{An overview plot for monte carlo simulation studies.}
\description{This package aims to simplify the process by offering a convenient way to generate comprehensive overview plots that summarize the key findings of simulation studies.}
\usage{
simulPlot(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{A long format of data frame including the methods, parameters, bias, and rmse.}
  \item{parameters}{A formula of parameters (e.g. ~ n+ lambda).
}
  \item{methods}{
The name of methods variable.}
  \item{bias}{
The name of bias variable.
}
  \item{rmse}{
The name of rmse variable.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{Neda Mohammadi\href{mailto:n.mohammadi.24@gmail.com}}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

# Generating Artificial Data
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
# Draw the Plot
plot=simulationPlot (
  data,
  parameters = ~ n:DGP:lambda,
  methods = "methods",
  bias = "bias",
  rmse = "rmse"
)
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ Simulation }
% \keyword{ Plot }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
