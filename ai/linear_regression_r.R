#!/usr/bin/env Rscript
# Command-line linear regression analysis for salary prediction.

suppressPackageStartupMessages({
  library(ggplot2)
})

OUTPUT_IMAGE <- "linear_regression_r_output.png"


parse_arguments <- function() {
  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) != 3) {
    stop(
      "Usage: Rscript linear_regression_r.R <filename> <x_column> <y_column>\n",
      "Example: Rscript linear_regression_r.R regression_data.csv YearsExperience Salary",
      call. = FALSE
    )
  }

  list(
    filename = args[[1]],
    x_column = args[[2]],
    y_column = args[[3]]
  )
}


validate_file_exists <- function(filepath) {
  if (!file.exists(filepath)) {
    stop("Input file not found: ", filepath, call. = FALSE)
  }
  if (isTRUE(file.info(filepath)$isdir)) {
    stop("Expected a file, but found a directory: ", filepath, call. = FALSE)
  }
}


load_dataset <- function(filepath, x_column, y_column) {
  data <- tryCatch(
    read.csv(filepath, stringsAsFactors = FALSE),
    error = function(error) {
      stop("Unable to read CSV file '", filepath, "': ", error$message, call. = FALSE)
    }
  )

  missing_columns <- setdiff(c(x_column, y_column), names(data))
  if (length(missing_columns) > 0) {
    stop(
      "Missing required column(s): ",
      paste(missing_columns, collapse = ", "),
      ". Available columns: ",
      paste(names(data), collapse = ", "),
      call. = FALSE
    )
  }

  subset <- data[, c(x_column, y_column), drop = FALSE]

  if (any(is.na(subset[[x_column]]) | is.na(subset[[y_column]]))) {
    stop("Predictor and response columns must not contain missing values.", call. = FALSE)
  }

  if (!is.numeric(subset[[x_column]])) {
    stop("Predictor column '", x_column, "' must be numeric.", call. = FALSE)
  }
  if (!is.numeric(subset[[y_column]])) {
    stop("Response column '", y_column, "' must be numeric.", call. = FALSE)
  }

  subset
}


fit_linear_regression <- function(data, x_column, y_column) {
  formula <- as.formula(paste(y_column, "~", x_column))
  model <- lm(formula, data = data)
  data$predicted <- predict(model, newdata = data)
  list(model = model, data = data)
}


print_model_summary <- function(model) {
  cat("Linear Regression Results\n")
  cat(strrep("-", 40), "\n", sep = "")
  print(summary(model))
}


create_regression_plot <- function(data, x_column, y_column, output_path) {
  plot <- ggplot(data, aes(x = .data[[x_column]], y = .data[[y_column]])) +
    geom_point(color = "red", size = 3, alpha = 0.85) +
    geom_line(
      aes(y = predicted),
      color = "blue",
      linewidth = 1.1
    ) +
    labs(
      title = "Salary vs Years of Experience",
      x = x_column,
      y = y_column
    ) +
    theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.5),
      panel.grid.minor = element_blank()
    )

  ggsave(output_path, plot = plot, width = 10, height = 6, dpi = 300)
}


main <- function() {
  args <- parse_arguments()
  validate_file_exists(args$filename)

  data <- load_dataset(args$filename, args$x_column, args$y_column)
  fit <- fit_linear_regression(data, args$x_column, args$y_column)

  print_model_summary(fit$model)
  create_regression_plot(
    fit$data,
    args$x_column,
    args$y_column,
    OUTPUT_IMAGE
  )
  cat("\nPlot saved to:", OUTPUT_IMAGE, "\n")
}


tryCatch(
  main(),
  error = function(error) {
    message("Error: ", conditionMessage(error))
    quit(status = 1)
  }
)
