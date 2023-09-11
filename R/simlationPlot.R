
simulationPlot = function(data, parameters, methods, bias, rmse) {
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

