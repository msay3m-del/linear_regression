#!/usr/bin/env python3
"""Command-line linear regression analysis for salary prediction."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score


OUTPUT_IMAGE = "linear_regression_python_output.png"


def parse_arguments() -> argparse.Namespace:
    """Parse and validate command-line arguments."""
    parser = argparse.ArgumentParser(
        description=(
            "Fit a simple linear regression model and save a scatter plot "
            "with the fitted regression line."
        )
    )
    parser.add_argument("filename", help="Path to the CSV data file.")
    parser.add_argument("x_column", help="Name of the predictor column.")
    parser.add_argument("y_column", help="Name of the response column.")
    return parser.parse_args()


def validate_file_exists(filepath: Path) -> None:
    """Ensure the input file exists and is readable."""
    if not filepath.exists():
        raise FileNotFoundError(f"Input file not found: {filepath}")
    if not filepath.is_file():
        raise ValueError(f"Expected a file, but found: {filepath}")


def load_dataset(filepath: Path, x_column: str, y_column: str) -> pd.DataFrame:
    """Load the dataset and validate required columns."""
    try:
        data = pd.read_csv(filepath)
    except Exception as exc:
        raise ValueError(f"Unable to read CSV file '{filepath}': {exc}") from exc

    missing_columns = [col for col in (x_column, y_column) if col not in data.columns]
    if missing_columns:
        available = ", ".join(data.columns.astype(str))
        raise ValueError(
            f"Missing required column(s): {', '.join(missing_columns)}. "
            f"Available columns: {available}"
        )

    subset = data[[x_column, y_column]].copy()
    if subset.isnull().any().any():
        raise ValueError("Predictor and response columns must not contain missing values.")

    if not np.issubdtype(subset[x_column].dtype, np.number):
        raise ValueError(f"Predictor column '{x_column}' must be numeric.")
    if not np.issubdtype(subset[y_column].dtype, np.number):
        raise ValueError(f"Response column '{y_column}' must be numeric.")

    return subset


def fit_linear_regression(
    data: pd.DataFrame, x_column: str, y_column: str
) -> tuple[LinearRegression, np.ndarray, np.ndarray]:
    """Fit a linear regression model and return fitted values."""
    x_values = data[[x_column]].values
    y_values = data[y_column].values

    model = LinearRegression()
    model.fit(x_values, y_values)
    predictions = model.predict(x_values)
    return model, x_values.ravel(), predictions


def print_model_metrics(
    model: LinearRegression,
    y_true: np.ndarray,
    y_pred: np.ndarray,
) -> None:
    """Print regression coefficients and evaluation metrics."""
    coefficient = model.coef_[0]
    intercept = model.intercept_
    r_squared = r2_score(y_true, y_pred)
    mse = mean_squared_error(y_true, y_pred)

    print("Linear Regression Results")
    print("-" * 40)
    print(f"Coefficient (slope): {coefficient:.4f}")
    print(f"Intercept:           {intercept:.4f}")
    print(f"R-squared:           {r_squared:.4f}")
    print(f"MSE:                 {mse:.4f}")


def create_regression_plot(
    x_values: np.ndarray,
    y_values: np.ndarray,
    predictions: np.ndarray,
    x_label: str,
    y_label: str,
    output_path: Path,
) -> None:
    """Create and save a publication-quality regression plot."""
    fig, ax = plt.subplots(figsize=(10, 6))

    ax.scatter(x_values, y_values, alpha=0.75, edgecolors="white", linewidth=0.6, label="Observed")
    sorted_indices = np.argsort(x_values)
    ax.plot(
        x_values[sorted_indices],
        predictions[sorted_indices],
        color="crimson",
        linewidth=2.0,
        label="Regression line",
    )

    ax.set_title("Salary vs Years of Experience", fontsize=14, fontweight="bold")
    ax.set_xlabel(x_label, fontsize=12)
    ax.set_ylabel(y_label, fontsize=12)
    ax.grid(True, linestyle="--", alpha=0.35)
    ax.legend(frameon=True)
    fig.tight_layout()
    fig.savefig(output_path, dpi=300, bbox_inches="tight")
    plt.close(fig)


def main() -> int:
    """Run the linear regression workflow from the command line."""
    args = parse_arguments()
    filepath = Path(args.filename)

    try:
        validate_file_exists(filepath)
        data = load_dataset(filepath, args.x_column, args.y_column)
        model, x_values, predictions = fit_linear_regression(
            data, args.x_column, args.y_column
        )
        y_values = data[args.y_column].values

        print_model_metrics(model, y_values, predictions)
        create_regression_plot(
            x_values,
            y_values,
            predictions,
            args.x_column,
            args.y_column,
            Path(OUTPUT_IMAGE),
        )
        print(f"\nPlot saved to: {OUTPUT_IMAGE}")
    except (FileNotFoundError, ValueError) as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
