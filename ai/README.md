# Assignment 2: Linear Regression (AI-Assisted Implementation)

This directory contains an independent AI-assisted implementation for comparing simple linear regression workflows in **Python** and **R**. The analysis predicts **Salary** from **YearsExperience** using `regression_data.csv`.

## Assignment Overview

The project demonstrates a complete scientific computing workflow:

- Exploratory data analysis and visualization
- Simple linear regression model fitting
- Model evaluation and interpretation
- Reproducible command-line scripts
- Jupyter notebook analyses exportable to HTML

Both languages implement the same modeling objective while following language-specific best practices.

## Dataset Description

**File:** `regression_data.csv`

| Column | Description |
|--------|-------------|
| `YearsExperience` | Years of professional experience (numeric predictor) |
| `Salary` | Annual salary in USD (numeric response) |

The dataset contains paired observations suitable for simple linear regression.

## Python Notebook Workflow

**Notebook:** `linear_regression_python.ipynb`

The Python notebook follows this sequence:

1. Import libraries (`pandas`, `numpy`, `matplotlib`, `seaborn`, `scikit-learn`)
2. Load and inspect the dataset
3. Compute summary statistics
4. Create a scatter plot
5. Fit `LinearRegression` from scikit-learn
6. Overlay the regression line
7. Report coefficient, intercept, R², and MSE
8. Interpret results and conclude

## R Notebook Workflow

**Notebook:** `linear_regression_r.ipynb`

The R notebook follows this sequence:

1. Import libraries (`tidyverse`, `ggplot2`)
2. Load and inspect the dataset
3. Compute summary statistics
4. Create a scatter plot with red points
5. Fit `lm()` model
6. Overlay a blue regression line
7. Display `summary(model)` with coefficients and R-squared
8. Interpret results and conclude

## Python CLI Workflow

**Script:** `linear_regression_python.py`

```bash
python linear_regression_python.py <filename> <x_column> <y_column>
```

**Example:**

```bash
python linear_regression_python.py regression_data.csv YearsExperience Salary
```

The script validates inputs, fits the model, prints metrics, and saves `linear_regression_python_output.png`.

## R CLI Workflow

**Script:** `linear_regression_r.R`

```bash
Rscript linear_regression_r.R <filename> <x_column> <y_column>
```

**Example:**

```bash
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary
```

The script validates inputs, fits the model, prints `summary(model)`, and saves `linear_regression_r_output.png`.

## Software Requirements

- Conda (Miniconda or Anaconda)
- Python 3.10+
- R 4.3+ with IRKernel
- JupyterLab

Core Python packages: `pandas`, `numpy`, `matplotlib`, `seaborn`, `scikit-learn`, `jupyterlab`, `notebook`, `ipykernel`

Core R packages: `r-base`, `r-irkernel`, `r-tidyverse`, `r-ggplot2`

Optional: `scipy`, `statsmodels`, `pip`

## Environment Creation Steps

From the repository root (parent of `ai/`):

```bash
conda env create -f environment.yml
conda activate assignment2_env
```

Register the R kernel for Jupyter (first-time setup):

```bash
R -e "IRkernel::installspec(name = 'ir', displayname = 'R')"
```

## Notebook Execution

Change into the `ai/` directory:

```bash
cd ai
conda activate assignment2_env
jupyter lab
```

Open and run:

- `linear_regression_python.ipynb` (Python 3 kernel)
- `linear_regression_r.ipynb` (R / IRkernel)

Execute all cells top-to-bottom (`Run` → `Run All Cells`).

## HTML Export Instructions

### JupyterLab (recommended)

1. Open the notebook in JupyterLab.
2. Run all cells so outputs and figures are populated.
3. Select **File → Save and Export Notebook As → HTML**.
4. Save as:
   - `linear_regression_python.html`
   - `linear_regression_r.html`

### Command line (nbconvert)

```bash
jupyter nbconvert --to html --execute linear_regression_python.ipynb
jupyter nbconvert --to html --execute linear_regression_r.ipynb
```

Exported HTML should render all markdown cells, code outputs, and embedded figures.

## Script Execution Examples

```bash
cd ai
conda activate assignment2_env

# Python
python linear_regression_python.py regression_data.csv YearsExperience Salary

# R
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary
```

## Expected Outputs

### Console output

Both scripts print regression results:

- **Python:** coefficient, intercept, R², MSE
- **R:** full `summary(model)` including coefficients, R-squared, and residual statistics

### Generated image files

| File | Description |
|------|-------------|
| `linear_regression_python_output.png` | Scatter plot with regression line (Python CLI) |
| `linear_regression_r_output.png` | Scatter plot with red points and blue regression line (R CLI) |

### Notebook HTML exports

| File | Description |
|------|-------------|
| `linear_regression_python.html` | Static HTML export of the Python notebook |
| `linear_regression_r.html` | Static HTML export of the R notebook |

## Output Image Descriptions

**Python plot (`linear_regression_python_output.png`):**

- X-axis: Years of Experience
- Y-axis: Salary
- Observed data as scatter points
- Crimson regression line overlay
- Title: "Salary vs Years of Experience"
- Publication-style formatting with grid and legend

**R plot (`linear_regression_r_output.png`):**

- X-axis: Years of Experience
- Y-axis: Salary
- Red scatter points
- Blue regression line
- Title: "Salary vs Years of Experience"
- Minimal ggplot2 theme suitable for reports

## Project Files

```
ai/
├── regression_data.csv
├── linear_regression_python.ipynb
├── linear_regression_python.html
├── linear_regression_r.ipynb
├── linear_regression_r.html
├── linear_regression_python.py
├── linear_regression_r.R
├── README.md
└── PROMPTS.md
```

Environment specification: `../environment.yml`
