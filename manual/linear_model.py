#!/usr/bin/env python
# coding: utf-8

# This notebook demonstrates a simple linear regression analysis using Python to model Salary based on Years of Experience.


import sys

# Check command-line arguments
if len(sys.argv) != 4:
    print("Usage: python linear_model.py <filename> <x_column> <y_column>")
    sys.exit(1)

filename = sys.argv[1]
x_col = sys.argv[2]
y_col = sys.argv[3]

# Read the dataset

# In[1]:


import pandas as pd
dataset = pd.read_csv(filename)

# Define variables
x = dataset[x_col]
y = dataset[y_col]

# Fit a linear model

# In[2]:


from sklearn.linear_model import LinearRegression
model = LinearRegression()
model.fit(dataset[[x_col]], dataset[[y_col]])


# This cell calculates the slope, intercept and the correlation coefficient. Slope indicates how much salary changes for each additional year of experience. Intercept is the predicted salary when experience is zero.Correlation coefficient (r) measures the strength of the relationship.

# In[3]:


from scipy.stats import linregress
slope, intercept, r_value, p_value, std_err = linregress(dataset[x_col], dataset[y_col])
print("Slope:", slope)
print("Intercept:", intercept)
print("Correlation coefficient (r):", r_value)


# This cell calculates the Mean Squared Error (MSE). MSE measures prediction error.

# In[4]:


from sklearn.metrics import mean_squared_error
mse = mean_squared_error(dataset[y_col], model.predict(dataset[[x_col]]))
print("Mean Squared Error:", mse)


# Plotting the data and the model

# In[5]:


import matplotlib.pyplot as plt
plt.figure(figsize=(8,6))
plt.scatter(dataset[x_col], dataset[y_col], color="red", label="Observed Data")
plt.plot(dataset[x_col], model.predict(dataset[[x_col]]), color="blue", label="Fitted Line")
plt.text(min(dataset[x_col]),max(dataset[y_col]),f"y = {slope:.2f}x + {intercept:.2f}\nr = {r_value:.2f}", bbox=dict(facecolor="white"))
plt.title(f"{y_col} vs {x_col}")
plt.xlabel(x_col)
plt.ylabel(y_col)
plt.legend()
plt.savefig("regression_plot_python.png")
print("Plot saved as regression_plot_python.png")
plt.show()