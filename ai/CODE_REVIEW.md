# AI Code Review

## Summary

This pull request (`assignment3` vs `main`) refactors the linear regression project from Assignment 2 into Assignment 3 deliverables. The changes rename scripts and notebooks from `linear_regression_*` to `linear_model_*`, extend the analysis with Pearson correlation (r), Mean Squared Error (MSE), R-squared, and annotated regression plots, and introduce new output filenames (`regression_plot_python.png`, `regression_plot_r.png`). The AI-assisted implementation (`ai/`) is substantially improved with modular CLI scripts, input validation, a portable `setupenv.sh`, and thorough notebook documentation. The manual implementation (`manual/`) meets core modeling requirements but retains notebook-to-script conversion artifacts and minimal defensive checks. Large legacy HTML exports were removed from `ai/` without replacement. The repository root `README.md` has been updated for Assignment 3 with current filenames, directory structure, quick-start commands, and links to `ai/README_AI.md` and this review.

## Strengths

- **Correct regression workflow:** Both Python and R implementations load CSV data, fit simple linear regression, compute slope and intercept, and produce scatter plots with fitted lines and equation/correlation annotations.
- **Strong AI code structure:** `ai/linear_model.py` and `ai/linear_model.R` are well-factored into single-responsibility functions (`parse_arguments`, `load_data`, `fit_regression`, `print_statistics`, `create_plot`) with docstrings and consistent output formatting.
- **Robust input validation (AI):** The AI scripts validate argument count, file existence, empty files, and column names, listing available columns on failure.
- **High-quality AI notebooks:** `ai/linear_model_python.ipynb` and `ai/linear_model_r.ipynb` include clear markdown sections for objective, data loading, model fitting, metric interpretation, visualization, and conclusions.
- **Reproducibility tooling (AI):** `ai/setupenv.sh` checks for conda, creates or updates the environment, registers the R Jupyter kernel, and verifies package installation with helpful post-setup instructions.
- **Documentation for AI workflow:** `ai/README_AI.md` and `ai/PROMPTS.md` clearly describe project structure, usage, libraries, and the prompts used to generate deliverables.
- **Updated root README:** The repository-level `README.md` now describes Assignment 3, documents the `linear_model_*` naming convention, lists correct output filenames, and links to `ai/README_AI.md`, `ai/PROMPTS.md`, and `ai/CODE_REVIEW.md`.
- **Manual HTML exports present:** `manual/linear_model_python.html` and `manual/linear_model_r.html` are included for grader review without requiring notebook execution.

## Detailed Findings

### Finding 1
Severity: Medium

Description:
The `ai/` folder removed the old notebook HTML exports (`linear_regression_python.html`, `linear_regression_r.html`) but did not add HTML exports for the new notebooks (`linear_model_python.ipynb`, `linear_model_r.ipynb`). The manual folder includes HTML exports; the AI folder does not, creating an inconsistency if HTML submission is required.

Recommendation:
Export `ai/linear_model_python.ipynb` and `ai/linear_model_r.ipynb` to HTML and commit them alongside the notebooks, matching the manual deliverable pattern.

### Finding 2
Severity: Medium

Description:
The manual CLI scripts (`manual/linear_model.py`, `manual/linear_model.r`) lack file-existence and column-name validation. A mistyped column or missing file produces a Python traceback or opaque R error rather than a user-friendly message. The AI scripts handle these cases correctly.

Recommendation:
Port the validation patterns from the AI scripts into the manual scripts, or extract shared validation logic so both implementations fail gracefully with actionable error messages.

### Finding 3
Severity: Medium

Description:
The AI CLI plotting functions hardcode axis labels and titles (`"Years of Experience"`, `"Salary"`) even though the scripts accept arbitrary `x_column` and `y_column` arguments. Using different column names would produce a plot whose labels do not match the data being analyzed.

Recommendation:
Parameterize plot labels using the supplied column names (as the manual Python script does with `plt.xlabel(x_col)`), or accept optional label arguments with sensible defaults derived from the column names.

### Finding 4
Severity: Low

Description:
The manual Python CLI script (`manual/linear_model.py`) retains Jupyter export artifacts (`# In[1]:`, `# In[2]:`, etc.) and calls `plt.show()` after saving, which is unnecessary in a non-interactive CLI context. It also prints slope, intercept, r, and MSE but not R-squared, while the notebook computes R-squared separately.

Recommendation:
Clean the script to remove notebook cell markers, drop `plt.show()`, and print R-squared in the CLI output for parity with the notebook and AI script.

### Finding 5
Severity: Low

Description:
The manual R script usage message references `linear_regression_r.R`, but the actual filename is `linear_model.r`. It also uses positional coefficient indexing (`coef(model)[2]`) and deprecated `aes_string()`, which are fragile if the formula or ggplot2 version changes.

Recommendation:
Fix the usage string to match `linear_model.r`, use named coefficient access (`coef(model)[x_col]`), and replace `aes_string()` with `aes()` using `.data[[x_col]]` notation.

### Finding 6
Severity: Medium

Description:
Reproducibility differs sharply between folders. `manual/environment.yml` is a fully pinned conda export, while `ai/environment.yml` uses unpinned minimum versions (`python>=3.10`, `r-base>=4.3`). The manual `setupenv.sh` is tied to OSC-specific modules (`module load miniconda3/24.1.2-py310`) and auto-starts JupyterLab on port 2000, limiting portability outside that cluster environment.

Recommendation:
Consider pinning key package versions in `ai/environment.yml` (at least major/minor versions used during development). Document OSC-specific assumptions in `manual/setupenv.sh` or split cluster-specific and portable setup steps.

### Finding 7
Severity: Low

Description:
`manual/readme.md` contains typos ("thid", "note books") and minor grammar issues.

Recommendation:
Proofread `manual/readme.md` for spelling and grammar.

## Suggested Improvements

1. **Complete AI notebook HTML exports:** Add static HTML exports for `ai/linear_model_python.ipynb` and `ai/linear_model_r.ipynb` so both folders offer the same grader-friendly notebook artifacts.

2. **Bring manual CLI scripts up to the AI standard for error handling:** Add file-existence checks, column validation with available-column hints, and consistent exit codes. This closes the largest functional gap between the hand-written and AI-assisted implementations.

3. **Make CLI plots truly column-driven:** Use the user-supplied column names for axis labels, titles, and annotation context in both Python and R scripts so the tools work as general-purpose regression utilities rather than single-dataset hardcoded plots.

4. **Align metric output across all entry points:** Ensure notebooks, Python scripts, and R scripts all report the same statistics (slope, intercept, Pearson r, MSE, R-squared) with consistent formatting and precision.

5. **Improve environment reproducibility for the AI folder:** Pin conda package versions in `ai/environment.yml` and note the tested Python/R versions in `README_AI.md` so future runs on different machines produce comparable results.

## Recommended Change To Implement First

**Add file and column validation to the manual CLI scripts.**

The AI scripts already demonstrate the correct pattern, but the manual scripts are the hand-graded baseline and currently fail with stack traces on common user errors (wrong filename, typo in column name). Validation is inexpensive to implement, immediately improves usability, and ensures both implementations behave predictably when run from the terminal—the primary grading interface for Part II.

## Final Assessment

**Approve with Suggestions**

The pull request successfully delivers Assignment 3's core requirements: enhanced regression diagnostics, annotated plots, renamed deliverables, updated repository documentation, and a polished AI-assisted implementation with modular code and strong documentation. Regression calculations appear methodologically sound in both languages (sklearn/scipy in Python, `lm()`/`cor()` in R), and committed plot PNGs demonstrate end-to-end execution. The review recommends changes rather than blocking merges because the remaining issues are primarily manual-script robustness, AI HTML export consistency, and reproducibility polish—not fundamental modeling errors.

## Addressed Feedback

Assume the following feedback was accepted and implemented:

"Added validation to ensure user-supplied column names exist before fitting the regression model."

Briefly explain why this improvement strengthens the project.

Column-name validation prevents silent misanalysis when a user mistypes a predictor or response column name. Without it, the script may raise a confusing `KeyError` (Python) or coercively fail mid-pipeline (R), which is especially problematic in a command-line grading context where TAs and students supply arbitrary column arguments. By checking columns immediately after loading the CSV and printing the available column list on failure, the tool fails fast with an actionable message. This improves user experience, reduces support burden during grading, and demonstrates defensive programming appropriate for reusable CLI utilities.

"Updated the repository root README for Assignment 3."

Briefly explain why this improvement strengthens the project.

The root README is the first document graders and collaborators encounter. Updating it to Assignment 3 naming (`linear_model_*`), correct plot output filenames, the current `manual/` and `ai/` structure, and links to `README_AI.md`, `PROMPTS.md`, and `CODE_REVIEW.md` removes confusion left over from Assignment 2. Accurate quick-start commands and a side-by-side comparison table give reviewers a reliable entry point without digging through stale filenames or broken links.
