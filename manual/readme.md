# Improved Linear regression Notebooks and Scripts

## Part I: The purpose of thid part is to create and compare linear regression models in Python and R using Jupyter Notebooks.

These note books can do the following:

1. Load and inspect a CSV dataset

2. Fit a linear regression model

3. Plot the regression line over the data

4. Evaluate the model’s performance

5. Calculate the slope and intercept of the fitted regression line

6. Calculate the correlation coefficient (Pearson's r)

7. Calculate the Mean Squared Error (MSE)

8. Display the regression equation and correlation coefficient on the plot

The following libraries were used in plotting, modeling, or reading data files

**For python:**

1. pandas
2. matplotlib
3. scikit-learn
4. scipy

**For R:**

1. ggplot2

## Part II: In this part, the Jupyter Notebooks (Python and R) are converted into a standalone script and run from the command line.

These scripts are capable of:

1. Running from the terminal (sys.argv in Python and commandArgs() in R stores the command-line arguments passed to a script when it is executed)

2. Fitting a linear regression model

3. Calculating and displaying the slope and intercept

4. Calculating and displaying the correlation coefficient

5. Calculating and displaying the MSE

6. Generating the regression plot

7. Displaying the regression equation and correlation coefficient on the plot

8. Saving the plot as an image file (.png)

9. Outputting model statistics to the screen

**Run Your Scripts from the Terminal**

To run these scripts, you need the:

1. The input CSV file name

2. The column name for the x variable (e.g., YearsExperience)

3. The column name for the y variable (e.g., Salary)

**Python**

`python linear_model.py regression_data.csv YearsExperience Salary`

**R**

`Rscript linear_model.r regression_data.csv YearsExperience Salary`

Output image files:

**Python**

`regression_plot_python.png`

**R**

`regression_plot_r.png`