# Assignment 3: Linear Regression in Python and R

This repository implements an enhanced simple linear regression workflow in **Python** and **R**, completed twice: once by hand (`manual/`) and once with AI assistance (`ai/`). Both implementations predict **Salary** from **YearsExperience** using `regression_data.csv`, compute regression diagnostics, and produce annotated scatter plots with fitted regression lines.

## Repository Structure

```
linear_regression/
├── README.md                      # This file — project overview
├── manual/                        # Part A: hand-written (no AI tools)
│   ├── readme.md
│   ├── regression_data.csv
│   ├── linear_model_python.ipynb
│   ├── linear_model_python.html
│   ├── linear_model_r.ipynb
│   ├── linear_model_r.html
│   ├── linear_model.py
│   ├── linear_model.r
│   ├── regression_plot_python.png
│   ├── regression_plot_r.png
│   ├── environment.yml
│   └── setupenv.sh
└── ai/                            # Part B: AI-assisted implementation
    ├── README_AI.md
    ├── PROMPTS.md
    ├── CODE_REVIEW.md
    ├── regression_data.csv
    ├── linear_model_python.ipynb
    ├── linear_model_r.ipynb
    ├── linear_model.py
    ├── linear_model.R
    ├── regression_plot_python.png
    ├── regression_plot_r.png
    ├── environment.yml
    └── setupenv.sh
```

| Folder | How it was built | Branch |
|--------|------------------|--------|
| `manual/` | Typed by hand, no AI | `main` |
| `ai/` | Generated with Cursor AI | `assignment3` |

Both folders are self-contained so graders can review each part independently.

## Dataset

**File:** `regression_data.csv` (present in both `manual/` and `ai/`)

| Column | Description |
|--------|-------------|
| `YearsExperience` | Years of professional experience (predictor) |
| `Salary` | Annual salary in USD (response) |

The dataset contains 10 paired observations suitable for simple linear regression.

## Assignment Requirements

### Part A — Manual (`manual/`)

No AI tools. All notebooks, scripts, and documentation were typed by hand.

**Notebooks (Part I)**

- Python Jupyter notebook (`.ipynb` + exported `.html`)
- R Jupyter notebook (`.ipynb` + exported `.html`)
- `regression_data.csv`
- Customized `readme.md`

Each notebook:

1. Loads and inspects the CSV file
2. Fits a linear regression model
3. Calculates slope, intercept, Pearson correlation (r), MSE, and R-squared
4. Creates a scatter plot with a fitted regression line
5. Annotates the plot with the regression equation and correlation coefficient

**Command-line scripts (Part II)**

- `linear_model.py` — Python script converted from the notebook
- `linear_model.r` — R script converted from the notebook

Both scripts accept:

```text
<filename> <x_column> <y_column>
```

Example:

```bash
python linear_model.py regression_data.csv YearsExperience Salary
Rscript linear_model.r regression_data.csv YearsExperience Salary
```

Output plot files:

- `regression_plot_python.png`
- `regression_plot_r.png`

### Part B — AI-assisted (`ai/`)

The same deliverables were regenerated using Cursor AI. See [`ai/PROMPTS.md`](ai/PROMPTS.md) for the prompts used during development and [`ai/CODE_REVIEW.md`](ai/CODE_REVIEW.md) for the AI-assisted code review.

**Required deliverables:**

- Python and R notebooks (`.ipynb`)
- Python and R CLI scripts with committed output PNGs
- `environment.yml` and `setupenv.sh`
- `README_AI.md`, `PROMPTS.md`, and `CODE_REVIEW.md`

The AI version is graded on correctness, not on matching the manual version line-for-line.

## Quick Start

### Manual version

```bash
cd manual
conda env create -f environment.yml   # creates env: 7030_class_1
conda activate 7030_class_1

# Run CLI scripts
python linear_model.py regression_data.csv YearsExperience Salary
Rscript linear_model.r regression_data.csv YearsExperience Salary

# Open notebooks in JupyterLab
jupyter lab
```

On OSC, you can also use the provided setup script:

```bash
cd manual
bash setupenv.sh
```

### AI version

```bash
cd ai
bash setupenv.sh                      # creates env: linear_regression_ai
conda activate linear_regression_ai

# Run CLI scripts
python linear_model.py regression_data.csv YearsExperience Salary
Rscript linear_model.R regression_data.csv YearsExperience Salary

# Open notebooks in JupyterLab
jupyter lab
```

## What Each Implementation Does

Both the manual and AI versions follow the same scientific workflow:

1. **Load data** — read `regression_data.csv` with pandas (Python) or base R (R)
2. **Fit model** — simple linear regression (`sklearn.LinearRegression` in Python, `lm()` in R)
3. **Evaluate** — report slope, intercept, Pearson r, MSE, and R-squared
4. **Visualize** — scatter plot with fitted regression line
5. **Annotate** — display the regression equation and correlation coefficient on the plot

### Libraries used

| Task | Manual (`manual/`) | AI (`ai/`) |
|------|-------------------|------------|
| Python data/plot/model | `pandas`, `matplotlib`, `scikit-learn`, `scipy` | `pandas`, `matplotlib`, `scipy`, `scikit-learn` |
| R data/plot/model | `ggplot2` | `ggplot2` |
| Jupyter | `jupyterlab`, `IRkernel` | `jupyterlab`, `notebook`, `IRkernel` |

## Manual vs. AI: Key Differences

| Aspect | Manual | AI-assisted |
|--------|--------|-------------|
| CLI structure | Notebook-to-script conversion | Modular functions with docstrings |
| Input validation | Basic argument count check | File-exists checks, column validation, clear error messages |
| Metric output | Slope, intercept, r, MSE (R-squared in notebook) | Slope, intercept, r, MSE, R-squared with formatted output |
| Plot styling | Red/blue scatter and line | Styled plots with annotation boxes and grid |
| R script filename | `linear_model.r` | `linear_model.R` |
| Environment | Fully pinned conda export (`7030_class_1`) | Minimal spec (`linear_regression_ai`) |
| Setup script | OSC-specific Jupyter launch | Portable conda setup with package verification |
| Documentation | Brief `readme.md` | `README_AI.md`, `PROMPTS.md`, `CODE_REVIEW.md` |

These differences reflect the trade-off between a hand-typed first pass (functional and direct) and an AI-assisted rebuild (more defensive, documented, and structured).

## Expected Outputs

### Committed plot images

| File | Produced by |
|------|-------------|
| `regression_plot_python.png` | Python CLI script |
| `regression_plot_r.png` | R CLI script |

### Exported notebook HTML (manual)

| File | Description |
|------|-------------|
| `linear_model_python.html` | Static HTML export of the Python notebook |
| `linear_model_r.html` | Static HTML export of the R notebook |

### Console output

Both implementations print regression statistics including:

- Slope and intercept
- Pearson correlation coefficient (r)
- Mean Squared Error (MSE)
- Regression equation (`y = mx + b`)

The AI scripts also print R-squared in a formatted summary block. The R manual script prints `summary(model)` after generating the plot.

## Further Reading

- [`manual/readme.md`](manual/readme.md) — detailed notes on the hand-written implementation
- [`ai/README_AI.md`](ai/README_AI.md) — full workflow guide for the AI-assisted version
- [`ai/PROMPTS.md`](ai/PROMPTS.md) — AI prompts used to generate Part B
- [`ai/CODE_REVIEW.md`](ai/CODE_REVIEW.md) — pull request-style review of the Assignment 3 changes
