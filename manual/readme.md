# Linear regression

## Part I: The purpose of these part is to create and compare linear regression models in Python and R using Jupyter Notebooks.

These note books can do the following:

1. Load and inspect a CSV dataset

2. Create a scatter plot of two variables

3. Fit a linear regression model

4. Plot the regression line over the data

5. Evaluate the model’s performance

The following libraries were used in plotting, modeling, or reading data files

**For python:**

1. pandas
2. matplotlib
3. scikit-learn

**For R:**

1. ggplot2

## Part II: In this part, the Jupyter Notebooks (Python and R) are converted into a standalone script and run from the command line.

These scripts are capable of:

1. Running from the terminal (sys.argv in Python and commandArgs() in R stores the command-line arguments passed to a script when it is executed) 

2. Generate the regression plot

3. Saving the plot as an image file (.png) or as output to the screen


**Run Your Scripts from the Terminal**

To run these scripts, you needs the:

1. The input CSV file name

2. The column name for the x variable (e.g., YearsExperience)

3. The column name for the y variable (e.g., Salary)

**Python**
`python linear_regression_python.py regression_data.csv YearsExperience Salary`

**R**
`Rscript linear_regression_r.R regression_data.csv YearsExperience Salary`

Output image files:

**Python**
linear_regression_python_output.png

**R**
linear_regression_r_output.png