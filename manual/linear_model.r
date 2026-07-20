args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 3) {
  stop("Usage: Rscript linear_regression_r.R <filename> <x_column> <y_column>")
}

filename <- args[1]
x_col <- args[2]
y_col <- args[3]

dataset <- read.csv(filename)

formula <- as.formula(paste(y_col, "~", x_col))

model <- lm(formula, data = dataset)

slope <- coef(model)[2]
intercept <- coef(model)[1]
r <- cor(dataset[[x_col]],dataset[[y_col]])
print(paste("Slope:", slope))
print(paste("Intercept:", intercept))
print(paste("Correlation coefficient (r):", r))

mse <- mean(
  (predict(model) - dataset[[y_col]])^2
)
print(paste("MSE:", mse))

library(ggplot2)
fig <- ggplot(dataset, aes_string(x = x_col, y = y_col)) +
  geom_point(color = "red") +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  annotate("text", x = min(dataset[[x_col]]), y = max(dataset[[y_col]]), hjust = 0, label = paste("y =", round(slope, 2), "x +", round(intercept, 2), "\nr =", round(r, 2))) +
  ggtitle(paste(y_col, "vs", x_col)) +
  xlab(x_col) +
  ylab(y_col)

ggsave("regression_plot_r.png", plot = fig, width = 8, height = 6)

print(fig)

print(summary(model))