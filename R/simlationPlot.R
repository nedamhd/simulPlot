#' Title An overview plot for monte carlo simulation studies
#' @author Neda Mohammadi
#' @param data A long format of data frame including the methods, parameters, bias, and rmse.
#' @param parameters A formula of parameters (e.g. ~ n+ lambda).
#' @param methods The name of methods variable.
#' @param bias The name of bias variable.
#' @param rmse The name of rmse variable.
#'
#' @return a plot of ggplot2 class.
#' @export
#'
#' @examples
#' # Generating Artificial Data
#'n = c(500, 1000, 5000)
#'DGP = c(1:4)
#'lambda = c(0.25, 0.5, 0.75)
#'methods = c(letters[1:5])
#'data = expand.grid(
  #'  n = n,
  #'  DGP = DGP,
  #'  lambda = lambda,
  #'  methods = methods
  #')
  #'data$bias = rnorm(dim(data)[1])
  #'data$rmse = runif(dim(data)[1])
  #'# Draw the Plot
  #'simlationPlot (
  #'  data,
  #'  parameters = ~ n:DGP:lambda,
  #'  methods = "methods",
  #'  bias = "bias",
  #'  rmse = "rmse"
  #')

simlationPlot = function(data, parameters, methods, bias, rmse) {
  require(dplyr)
  interaction.data = data[, all.vars(parameters)]
  data$interaction =  interaction(interaction.data)
  df = data %>% group_by(interaction) %>% mutate(biasRank = rank(abs(bias)), rmseRank = rank(rmse))
  require(ggh4x)
  require(ggplot2)
  biasRank.max = max(df$biasRank)
  p <-    df  %>% ggplot(aes(x = interaction, y = methods, )) +
    geom_point(aes(
      color = as.factor(max(biasRank, na.rm = TRUE) - biasRank + 1),
      size =  as.factor(max(biasRank, na.rm = TRUE) - biasRank + 1),
      fill =  as.factor(max(biasRank, na.rm = TRUE) - biasRank + 1)
    )) +
    scale_size_manual(values   = c(5:(biasRank.max + 5)), labels =  biasRank.max:1) +
    scale_fill_manual(values   = c(5:(biasRank.max + 5)), labels =  biasRank.max:1) +

    scale_color_manual(
      labels = biasRank.max:1 ,
      values = c(
        "#33FF00" ,
        "#CCFF66",
        "#FFFF00" ,
        "#FFFF99",
        "#FFCC99",
        "#FF6666" ,
        "#FF3333" ,
        "#FF3300",
        "#FF0000",
        "#CC0000",
        "#990000"
      )[biasRank.max:1]
    ) +
    geom_text(aes(label = rmseRank), size = 4) + theme_bw() +
    scale_x_discrete(NULL, guide = "axis_nested") +
    labs(
      fill = "Reverse Rank \nof Bias",
      y = "",
      x = "",
      size   = "Reverse Rank \nof Bias",
      color  = "Reverse Rank \nof Bias"
    ) +
    theme(
      axis.text.y  = element_text(
        colour = "black",
        face = "bold",
        size = 11
      ),
      axis.text.x  = element_text(colour = "black", face = "bold"),
      legend.text  = element_text(
        colour = "black",
        face = "bold",
        size = 10
      ),
      legend.title = element_text(
        colour = "black",
        face = "bold",
        size = 12
      )
    )
  p
}

