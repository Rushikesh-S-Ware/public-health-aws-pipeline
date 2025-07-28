#!/usr/bin/env python
# coding: utf-8

# In[12]:


# Load the full dataset to perform detailed analysis
import  pandas as pd
full_data_path = 'Drug_overdose.csv'
Drug_overdose = pd.read_csv(full_data_path)

# Get a summary of the dataset, including checking for missing values in key columns
Drug_overdose.info(), Drug_overdose.describe(include='all')


# In[ ]:





# In[ ]:





# In[13]:


# Replace NaN values in 'ESTIMATE' with 0 for calculation purposes (assumes no data means no reported deaths, could be debated)
Drug_overdose['ESTIMATE'] = Drug_overdose['ESTIMATE'].fillna(0)


# Confirm replacement
Drug_overdose['ESTIMATE'].isnull().sum()


# In[14]:


# Grouping the data by 'STUB_LABEL' and 'YEAR' to find average estimates per demographic group per year
grouped_data = Drug_overdose.groupby(['STUB_LABEL', 'YEAR'])['ESTIMATE'].mean().reset_index()

# Pivoting the data for better visualization
pivot_table = grouped_data.pivot(index='YEAR', columns='STUB_LABEL', values='ESTIMATE')

# Showing a preview of the pivoted data
pivot_table.head(), pivot_table.columns


# In[ ]:





# In[18]:


import matplotlib.pyplot as plt

# Set up the plotting environment
plt.figure(figsize=(14, 8))

# Plotting multiple groups for comparison
# Example groups: "All persons", "Female: Not Hispanic or Latino: White", "Male: Black or African American", and "25-34 years"
plt.plot(pivot_table.index, pivot_table['All persons'], label='All persons', marker='o')
plt.plot(pivot_table.index, pivot_table['Female: Not Hispanic or Latino: White'], label='Female: Not Hispanic or Latino: White', marker='o')
plt.plot(pivot_table.index, pivot_table['Male: Black or African American'], label='Male: Black or African American', marker='o')
plt.plot(pivot_table.index, pivot_table['25-34 years'], label='25-34 years', marker='o')

# Adding titles and labels
plt.title('Trends in Drug Overdose Death Rates by Demographic Groups')
plt.xlabel('Year')
plt.ylabel('Death Rates per 100,000 Population')
plt.legend()
plt.grid(True)

plt.savefig('/home/ec2-user/graph.jpg', format='jpg', dpi=300)


# Show the plot
plt.show()


# In[16]:


from scipy.stats import linregress

# Set up the plotting environment
plt.figure(figsize=(14, 8))

# Groups to analyze with regression
groups = ['All persons', 'Female: Not Hispanic or Latino: White', 
          'Male: Black or African American', '25-34 years']

colors = ['blue', 'green', 'red', 'purple']  # Colors for the lines

for group, color in zip(groups, colors):
    # Actual data
    plt.plot(pivot_table.index, pivot_table[group], label=f'Actual {group}', marker='o', color=color)
    
    # Perform linear regression
    slope, intercept, r_value, p_value, std_err = linregress(pivot_table.index, pivot_table[group])
    # Calculate the line of best fit
    line = slope * pivot_table.index + intercept
    # Plot the line of best fit
    plt.plot(pivot_table.index, line, label=f'Regression {group}', linestyle='--', color=color)

# Adding titles and labels
plt.title('Trends and Linear Regression of Drug Overdose Death Rates by Demographic Groups')
plt.xlabel('Year')
plt.ylabel('Death Rates per 100,000 Population')
plt.legend()
plt.grid(True)

plt.savefig('/home/ec2-user/regression.jpg', format='jpg', dpi=300)


# Show the plot
plt.show()


# In[ ]:





# In[17]:


import statsmodels.api as sm

# Dictionary to store regression results for easier access
regression_results = {}

for group in groups:
    # Adding a constant to the input features
    X = sm.add_constant(pivot_table.index)  # adding a constant
    y = pivot_table[group]
    
    # Creating the model
    model = sm.OLS(y, X)
    results = model.fit()
    
    # Store results in dictionary
    regression_results[group] = results

    # Print the summary for each group
    print(f"Regression Summary for {group}:")
    print(results.summary())
    print("\n\n")


# In[ ]:




