#!/usr/bin/env python3
"""
Command-line linear regression analysis.

Usage:
    python linear_model.py <filename> <x_column> <y_column>

Example:
    python linear_model.py regression_data.csv YearsExperience Salary
"""

import sys

import matplotlib.pyplot as plt
import pandas as pd
from scipy.stats import pearsonr
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score


def parse_arguments(argv):
    """Validate and return command-line arguments."""
    if len(argv) != 4:
        print(
            "Usage: python linear_model.py <filename> <x_column> <y_column>",
            file=sys.stderr,
        )
        sys.exit(1)
    return argv[1], argv[2], argv[3]


def load_data(filename, x_column, y_column):
    """Read CSV and validate that requested columns exist."""
    try:
        data = pd.read_csv(filename)
    except FileNotFoundError:
        print(f"Error: file not found: {filename}", file=sys.stderr)
        sys.exit(1)
    except pd.errors.EmptyDataError:
        print(f"Error: file is empty: {filename}", file=sys.stderr)
        sys.exit(1)

    missing = [col for col in (x_column, y_column) if col not in data.columns]
    if missing:
        print(
            f"Error: column(s) not found: {', '.join(missing)}",
            file=sys.stderr,
        )
        print(f"Available columns: {', '.join(data.columns)}", file=sys.stderr)
        sys.exit(1)

    return data


def fit_regression(x, y):
    """Fit linear regression and compute evaluation metrics."""
    x_values = x.values.reshape(-1, 1)
    y_values = y.values

    model = LinearRegression()
    model.fit(x_values, y_values)
    predictions = model.predict(x_values)

    slope = model.coef_[0]
    intercept = model.intercept_
    r_value, _ = pearsonr(x_values.ravel(), y_values)
    mse = mean_squared_error(y_values, predictions)
    r_squared = r2_score(y_values, predictions)

    return slope, intercept, r_value, mse, r_squared, predictions


def print_statistics(slope, intercept, r_value, mse, r_squared):
    """Print regression statistics to standard output."""
    print("Linear Regression Results")
    print("=" * 40)
    print(f"Slope:                 {slope:.4f}")
    print(f"Intercept:             {intercept:.4f}")
    print(f"Pearson r:             {r_value:.4f}")
    print(f"Mean Squared Error:    {mse:.4f}")
    print(f"R-squared:             {r_squared:.4f}")
    print(f"Equation:              y = {slope:.4f}x + {intercept:.4f}")


def create_plot(
    x,
    y,
    predictions,
    slope,
    intercept,
    r_value,
    x_column,
    y_column,
    output_path,
):
    """Create scatter plot with regression line and annotations."""
    fig, ax = plt.subplots(figsize=(10, 6))

    ax.scatter(x, y, alpha=0.7, edgecolors="black", linewidth=0.5, label="Observations")
    ax.plot(x, predictions, color="red", linewidth=2, label="Regression line")

    equation_text = f"y = {slope:.2f}x + {intercept:.2f}"
    correlation_text = f"r = {r_value:.4f}"

    ax.text(
        0.05,
        0.95,
        f"{equation_text}\n{correlation_text}",
        transform=ax.transAxes,
        fontsize=12,
        verticalalignment="top",
        bbox=dict(boxstyle="round", facecolor="white", alpha=0.85),
    )

    ax.set_xlabel(x_column)
    ax.set_ylabel(y_column)
    ax.set_title(f"{y_column} vs {x_column}")
    ax.legend()
    ax.grid(True, linestyle="--", alpha=0.4)

    fig.tight_layout()
    fig.savefig(output_path, dpi=150)
    plt.close(fig)


def main():
    filename, x_column, y_column = parse_arguments(sys.argv)
    data = load_data(filename, x_column, y_column)

    x = data[x_column]
    y = data[y_column]

    slope, intercept, r_value, mse, r_squared, predictions = fit_regression(x, y)
    print_statistics(slope, intercept, r_value, mse, r_squared)
    create_plot(
        x,
        y,
        predictions,
        slope,
        intercept,
        r_value,
        x_column,
        y_column,
        "regression_plot_python.png",
    )
    print("\nPlot saved to regression_plot_python.png")


if __name__ == "__main__":
    main()
