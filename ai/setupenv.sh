#!/usr/bin/env bash
#
# Setup script for the linear regression AI project.
# Creates the conda environment, registers the R kernel, and verifies packages.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_NAME="linear_regression_ai"
ENV_FILE="${SCRIPT_DIR}/environment.yml"

echo "=== Linear Regression AI Environment Setup ==="

# Ensure conda is available.
if ! command -v conda >/dev/null 2>&1; then
  echo "Error: conda is not installed or not on PATH." >&2
  echo "Install Miniconda or Anaconda, then rerun this script." >&2
  exit 1
fi

# Initialize conda for this shell session.
# shellcheck disable=SC1091
source "$(conda info --base)/etc/profile.d/conda.sh"

echo "Creating conda environment from ${ENV_FILE}..."
if conda env list | awk '{print $1}' | grep -qx "${ENV_NAME}"; then
  echo "Environment '${ENV_NAME}' already exists. Updating..."
  conda env update -n "${ENV_NAME}" -f "${ENV_FILE}" --prune
else
  conda env create -f "${ENV_FILE}"
fi

echo "Activating environment '${ENV_NAME}'..."
conda activate "${ENV_NAME}"

echo "Registering R kernel with Jupyter..."
R -e "IRkernel::installspec(name = 'ir', displayname = 'R (linear_regression_ai)')"

echo "Verifying Python packages..."
python - <<'PY'
import importlib.util

packages = ["pandas", "matplotlib", "scipy", "sklearn", "jupyterlab", "notebook"]
missing = [name for name in packages if importlib.util.find_spec(name) is None]
if missing:
    raise SystemExit(f"Missing Python packages: {', '.join(missing)}")
print("All required Python packages are installed.")
PY

echo "Verifying R packages..."
R -e "stopifnot(requireNamespace('ggplot2', quietly = TRUE)); cat('ggplot2 is installed.\n')"

echo
echo "Setup complete."
echo
echo "To launch JupyterLab:"
echo "  conda activate ${ENV_NAME}"
echo "  cd ${SCRIPT_DIR}"
echo "  jupyter lab"
echo
echo "Select the Python 3 kernel for linear_model_python.ipynb"
echo "and the R (linear_regression_ai) kernel for linear_model_r.ipynb."
