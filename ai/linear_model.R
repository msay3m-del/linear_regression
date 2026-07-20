#!/usr/bin/env Rscript
#
# Command-line linear regression analysis.
#
# Usage:
#   Rscript linear_model.R <filename> <x_column> <y_column>
#
# Example:
#   Rscript linear_model.R regression_data.csv YearsExperience Salary

suppressPackageStartupMessages({
  library(ggplot2)
})

# Parse and validate command-line arguments.
parse_arguments <- function() {
  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) != 3) {
    cat(
      "Usage: Rscript linear_model.R <filename> <x_column> <y_column>\n",
      file = stderr()
    )
    quit(status = 1)
  }

  list(
    filename = args[1],
    x_column = args[2],
    y_column = args[3]
  )
}

# Read CSV and validate that requested columns exist.
load_data <- function(filename, x_column, y_column) {
  if (!file.exists(filename)) {
    cat(sprintf("Error: file not found: %s\n", filename), file = stderr())
    quit(status = 1)
  }

  data <- tryCatch(
    read.csv(filename, stringsAsFactors = FALSE),
    error = function(e) {
      cat(sprintf("Error reading file: %s\n", e$message), file = stderr())
      quit(status = 1)
    }
  )

  missing <- setdiff(c(x_column, y_column), names(data))
  if (length(missing) > 0) {
    cat(
      sprintf("Error: column(s) not found: %s\n", paste(missing, collapse = ", ")),
      file = stderr()
    )
    cat(
      sprintf("Available columns: %s\n", paste(names(data), collapse = ", ")),
      file = stderr()
    )
    quit(status = 1)
  }

  data
}

# Fit linear regression and compute evaluation metrics.
fit_regression <- function(data, x_column, y_column) {
  formula <- as.formula(paste(y_column, "~", x_column))
  model <- lm(formula, data = data)

  slope <- coef(model)[x_column]
  intercept <- coef(model)["(Intercept)"]
  predictions <- fitted(model)

  x_values <- data[[x_column]]
  y_values <- data[[y_column]]

  r_value <- cor(x_values, y_values, method = "pearson")
  mse <- mean((y_values - predictions)^2)
  r_squared <- summary(model)$r.squared

  list(
    slope = slope,
    intercept = intercept,
    r_value = r_value,
    mse = mse,
    r_squared = r_squared,
    predictions = predictions,
    x_values = x_values,
    y_values = y_values
  )
}

# Print regression statistics to standard output.
print_statistics <- function(slope, intercept, r_value, mse, r_squared) {
  cat("Linear Regression Results\n")
  cat(paste(rep("=", 40), collapse = ""), "\n")
  cat(sprintf("Slope:                 %.4f\n", slope))
  cat(sprintf("Intercept:             %.4f\n", intercept))
  cat(sprintf("Pearson r:             %.4f\n", r_value))
  cat(sprintf("Mean Squared Error:    %.4f\n", mse))
  cat(sprintf("R-squared:             %.4f\n", r_squared))
  cat(sprintf("Equation:              y = %.4f x + %.4f\n", slope, intercept))
}

# Create scatter plot with regression line and annotations.
create_plot <- function(
  data,
  x_column,
  y_column,
  slope,
  intercept,
  r_value,
  output_path
) {
  plot_data <- data.frame(
    x = data[[x_column]],
    y = data[[y_column]]
  )

  equation_text <- sprintf("y = %.2f x + %.2f", slope, intercept)
  correlation_text <- sprintf("r = %.4f", r_value)
  annotation_text <- paste(equation_text, correlation_text, sep = "\n")

  p <- ggplot(plot_data, aes(x = x, y = y)) +
    geom_point(alpha = 0.7, color = "steelblue", size = 3) +
    geom_smooth(method = "lm", se = FALSE, color = "red", linewidth = 1) +
    annotate(
      "label",
      x = min(plot_data$x) + 0.05 * diff(range(plot_data$x)),
      y = max(plot_data$y),
      label = annotation_text,
      hjust = 0,
      vjust = 1,
      fill = "white",
      alpha = 0.85,
      size = 4
    ) +
    labs(
      title = paste(y_column, "vs", x_column),
      x = x_column,
      y = y_column
    ) +
    theme_minimal()

  ggsave(output_path, plot = p, width = 10, height = 6, dpi = 150)
}

main <- function() {
  args <- parse_arguments()
  data <- load_data(args$filename, args$x_column, args$y_column)

  results <- fit_regression(data, args$x_column, args$y_column)
  print_statistics(
    results$slope,
    results$intercept,
    results$r_value,
    results$mse,
    results$r_squared
  )

  create_plot(
    data,
    args$x_column,
    args$y_column,
    results$slope,
    results$intercept,
    results$r_value,
    "regression_plot_r.png"
  )

  cat("\nPlot saved to regression_plot_r.png\n")
}

main()
