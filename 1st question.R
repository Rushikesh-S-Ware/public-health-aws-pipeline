# Load necessary libraries
library(dplyr)
library(ggplot2)

# Assuming the data is already loaded into a DataFrame Drug_overdose
Drug_overdose <- read.csv('Drug_overdose.csv')

# Ensure that 'year' is treated as a numerical variable for regression analysis
Drug_overdose$year <- as.numeric(Drug_overdose$year)

# Filter the dataset for aggregate drug data
Drug_overdose_all_drugs <- Drug_overdose %>% 
  filter(PANEL == "All drug overdose deaths")  # Adjust the condition based on your actual data column and value

# Fit a linear regression model for the filtered data
model_all_drugs <- lm(ESTIMATE ~ YEAR, data = Drug_overdose_all_drugs)

# Summary of the model to view coefficients and statistics
summary(model_all_drugs)

# Plotting the data and the regression line for all drug overdose deaths
ggplot(Drug_overdose_all_drugs, aes(x = YEAR, y = ESTIMATE)) +
  geom_point(alpha = 0.6) +  # Points plot
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Regression line
  labs(title = "Trend of All Drug Overdose Death Rates Over Time",
       x = "Year",
       y = "Death Rate per 100,000") +
  theme_minimal()

Drug_overdose_all <- Drug_overdose[1:20, ]

ggplot(Drug_overdose_all, aes(x = YEAR, y = ESTIMATE)) +
  geom_point(alpha = 0.6) +  # Points plot
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Regression line
  labs(title = "Trend of All Drug Overdose Death Rates Over Time",
       x = "Year",
       y = "Death Rate per 100,000") +
  theme_minimal()

model1 <- lm(ESTIMATE ~ YEAR, data = Drug_overdose_all)

summary(model1)

plot(model1)

plot(Drug_overdose_all, aes(x = YEAR, y = ESTIMATE))

# Fit a linear regression model with a quadratic term
model_enhanced <- lm(ESTIMATE ~ YEAR + I(YEAR^2), data = Drug_overdose_all)

# Summary of the enhanced model
summary(model_enhanced)

# Diagnostic plots
par(mfrow = c(2, 2))
plot(model_enhanced)

