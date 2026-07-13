# Assignment 2: Linear Regression in Python and R

This repository compares simple linear regression workflows in **Python** and **R**, completed twice: once by hand (Part A) and once with AI assistance (Part B). Both implementations predict **Salary** from **YearsExperience** using `regression_data.csv`.

## Repository Structure

```
assignment_2/
├── README.md                 # This file — overview of the full project
├── manual/                   # Part A: hand-written (no AI tools)
│   ├── readme.md
│   ├── regression_data.csv
│   ├── linear_regression_python.ipynb
│   ├── linear_regression_python.html
│   ├── linear_regression_r.ipynb
│   ├── linear_regression_r.html
│   ├── linear_regression_python.py
│   ├── linear_regression_r.r
│   ├── linear_regression_python_output.png
│   ├── linear_regression_r_output.png
│   └── environment.yml
└── ai/                       # Part B: AI-assisted rebuild
    ├── README.md
    ├── PROMPTS.md
    ├── regression_data.csv
    ├── linear_regression_python.ipynb
    ├── linear_regression_python.html
    ├── linear_regression_r.ipynb
    ├── linear_regression_r.html
    ├── linear_regression_python.py
    ├── linear_regression_r.R
    ├── linear_regression_python_output.png
    ├── linear_regression_r_output.png
    └── environment.yml
```

| Folder | How it was built | Branch equivalent |
|--------|------------------|-------------------|
| `manual/` | Typed by hand, no AI | `main` branch |
| `ai/` | Rebuilt via AI prompts (Cursor) | `ai/` branch |

Both folders are self-contained copies of the same deliverables so graders can review each part independently.

## Dataset

**File:** `regression_data.csv` (present in both `manual/` and `ai/`)

| Column | Description |
|--------|-------------|
| `YearsExperience` | Years of professional experience (predictor) |
| `Salary` | Annual salary in USD (response) |

The dataset contains 10 paired observations suitable for simple linear regression.

## Assignment Requirements

### Part A — Manual (`manual/`, 20 pts)

No AI tools. All notebooks, scripts, and documentation were typed by hand.

**Notebooks & outputs (12 pts)**

- Python Jupyter notebook (`.ipynb` + exported `.html`)
- R Jupyter notebook (`.ipynb` + exported `.html`)
- `regression_data.csv`
- Customized `readme.md`

Each notebook:

1. Reads the CSV file
2. Creates a scatter plot
3. Fits a linear model
4. Overlays the regression line
5. Evaluates the model

**Command-line scripts (8 pts)**

- `linear_regression_python.py` — converted from the Python notebook
- `linear_regression_r.r` — converted from the R notebook

Both scripts accept: `<filename> <x_column> <y_column>` and save plot images (`linear_regression_python_output.png`, `linear_regression_r_output.png`).

### Part B — AI-assisted (`ai/`, 12 pts)

The same deliverables were regenerated using Cursor AI. See `ai/PROMPTS.md` for the 3–5 most important prompts used during vibe-coding.

**Required deliverables:**

- Python and R notebooks (`.ipynb` + `.html`)
- Python and R CLI scripts with committed output PNGs
- `ai/PROMPTS.md` documenting key AI prompts

The AI version is graded on correctness, not on matching the manual version line-for-line.

## Quick Start

### Manual version

```bash
cd manual
conda env create -f environment.yml   # creates env: 7030_class_1
conda activate 7030_class_1

# Run CLI scripts
python linear_regression_python.py regression_data.csv YearsExperience Salary
Rscript linear_regression_r.r regression_data.csv YearsExperience Salary

# Open notebooks in JupyterLab
jupyter lab
```

### AI version

```bash
cd ai
conda env create -f environment.yml   # creates env: assignment2_env
conda activate assignment2_env

# Register R kernel (first-time setup)
R -e "IRkernel::installspec(name = 'ir', displayname = 'R')"

# Run CLI scripts
python linear_regression_python.py regression_data.csv YearsExperience Salary
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary

# Open notebooks in JupyterLab
jupyter lab
```

## What Each Implementation Does

Both the manual and AI versions follow the same scientific workflow:

1. **Load data** — read `regression_data.csv` with pandas (Python) or base R / tidyverse (R)
2. **Explore** — summary statistics and scatter plot of experience vs. salary
3. **Model** — fit simple linear regression (`sklearn.LinearRegression` in Python, `lm()` in R)
4. **Visualize** — overlay the fitted regression line on the scatter plot
5. **Evaluate** — report coefficients, R², and (in the AI version) MSE

### Libraries used

| Task | Manual (`manual/`) | AI (`ai/`) |
|------|-------------------|------------|
| Python data/plot/model | `pandas`, `matplotlib`, `scikit-learn` | `pandas`, `numpy`, `matplotlib`, `seaborn`, `scikit-learn` |
| R data/plot/model | `ggplot2` | `tidyverse`, `ggplot2` |

## Manual vs. AI: Key Differences (Part C)

The two implementations solve the same problem but differ in structure and polish:

| Aspect | Manual | AI-assisted |
|--------|--------|-------------|
| CLI argument parsing | `sys.argv` (Python), `commandArgs()` (R) | `argparse` (Python), structured helper functions (R) |
| Input validation | Minimal usage check | File-exists checks, column validation, clear error messages |
| Model metrics | Basic coefficient display | R², MSE, and formatted summary output |
| Plot styling | Simple red points + blue line | Publication-style formatting, tuned axis intervals, smaller fonts |
| R script filename | `linear_regression_r.r` | `linear_regression_r.R` |
| Environment file | Fully pinned conda export (`7030_class_1`) | Minimal spec (`assignment2_env`) |
| Documentation | Brief `readme.md` | Detailed `README.md` + `PROMPTS.md` |

These differences reflect the trade-off between a hand-typed first pass (functional, direct) and an AI-assisted rebuild (more defensive, documented, and visually refined).

## Expected Outputs

### Committed plot images

| File | Produced by |
|------|-------------|
| `linear_regression_python_output.png` | Python CLI script |
| `linear_regression_r_output.png` | R CLI script |

### Exported notebook HTML

| File | Description |
|------|-------------|
| `linear_regression_python.html` | Static HTML export of the Python notebook |
| `linear_regression_r.html` | Static HTML export of the R notebook |

### Console output

- **Python:** regression coefficient, intercept, R², MSE
- **R:** full `summary(model)` with coefficients, R-squared, and residual statistics

## Part C — Reflection

See [`REFLECTION.md`](REFLECTION.md) for a comparison of the manual and AI implementations: structural differences, readability, bugs, and CLI behavior.

## Further Reading

- [`REFLECTION.md`](REFLECTION.md) — Part C reflection on manual vs. AI approaches
- [`manual/readme.md`](manual/readme.md) — detailed notes on the hand-written implementation
- [`ai/README.md`](ai/README.md) — full workflow guide for the AI-assisted version
- [`ai/PROMPTS.md`](ai/PROMPTS.md) — the AI prompts used to generate Part B
