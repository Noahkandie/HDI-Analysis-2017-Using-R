library(readr)
library(dplyr)
library(visdat)
library(ggplot2)


hdi <- read_csv("C:/Users/ok/Downloads/hdi_human_development_index.csv")

summary(hdi)
head(hdi)
colSums(is.na(hdi))
str(hdi)



popn <- read_csv("C:/Users/ok/Downloads/population_growth_annual_percent.csv")
summary(popn)
head(popn)
str(popn)
colSums(is.na(popn))

tax <- read_csv("C:/Users/ok/Downloads/tax_revenue_percent_of_gdp.csv")
summary(tax)
head(tax)
colSums(is.na(tax))
 

# Change the columns names to character to prevent errors.
colnames(tax) <- as.character(colnames(tax))
colnames(hdi) <- as.character(colnames(hdi))
colnames(popn) <- as.character(colnames(popn))

# Select the year 2017 from each dataset
tax_2017 <- tax[, c("country", "2017")]
hdi_2017 <- hdi[, c("country", "2017")]
popn_2017 <- popn[, c("country", "2017")]

# Merge datasets using the 'country' column
merged_data <- merge(merge(tax_2017, popn_2017, by = "country", all = TRUE), hdi_2017, by = "country", all = TRUE)

# Print the merged dataset
print(merged_data)

# Check structure
str(merged_data)

# Rename the columns to 'country', 'tax', 'population', and 'hdi'
colnames(merged_data) <- c("country", "tax", "population", "hdi")

#Change the negative sign in the population column
merged_data$population <- gsub("−", "-", merged_data$population)

# Convert the columns to numeric
colsnum <- c('tax','population','hdi')
merged_data[colsnum] <- lapply(merged_data[colsnum], as.numeric)



# Plot missing values
vis_miss(merged_data)

# Lets preview the rows with NA
merged_data[!complete.cases(merged_data), ]
# And countries with NA
merged_data[!complete.cases(merged_data), ]['country']

# Drop the rows with any NA
complete_df <- merged_data[complete.cases(merged_data), ]


vis_miss(complete_df)
str(complete_df)

# Boxplots
# Ass
# Create a matrix with the columns of interest
data_matrix <- cbind(complete_df$tax, complete_df$population, complete_df$hdi)

# Boxplot for 'tax,' 'popn,' and 'hdi' in a single plot
boxplot(data_matrix, col = c("orange","maroon", "red"), names = c("Tax", "Population", "HDI"),
        main = "Boxplots of Tax, Population, and HDI", ylab = "Values")
legend("topright", legend = c("Tax", "Population", "HDI"), fill = c("orange","maroon", "red"))

# No presence of outliers, we shall move on. However, we have had a high data loss
# which we shall try to study thereafter.


# Exploratory analysis
# histogram of HDI distribution
hist(complete_df$hdi,
     main="Human Development Index",
     xlab="HDI",
     col="darkmagenta")

abline(v = mean(complete_df$hdi), col = "blue", lty = 2, lw = 2)

# Tax Histogram
hist(complete_df$tax,
     main="Tax",
     xlab="Tax revenue percent of GDP ",
     col="plum",
     freq=TRUE )
abline(v = mean(complete_df$tax), col = "blue", lty = 2, lw = 2)

# Tax Histogram
hist(complete_df$population,
     main="Population growth of the countries",
     xlab="2017 population growth",
     col="magenta",
     freq=TRUE )
abline(v = mean(complete_df$population), col = "blue", lty = 2, lw = 2)

summary(complete_df)

# Convert hdi to categories
complete_df$hdi_category <- cut(complete_df$hdi, breaks = c(-Inf,  0.7, Inf), labels = c("Low",  "High"), include.lowest = TRUE)

# Analyse the new column
column_counts <- table(complete_df$hdi_category)
# Bar plot
barplot(column_counts, main="HDI value counts", 
        xlab="HDI Category", ylab="Frequency")


# Filter the data for low and high hdi_categories
filtered_data <- complete_df[complete_df$hdi_category %in% c("Low", "High"), ]

# Create a boxplot
cat = c("610C04", "7E2811")

ggplot(filtered_data, aes(x = hdi_category, y = tax)) +
  geom_boxplot( fill= cat) +
  labs(title = "Boxplot of Tax by HDI Categories",
       x = "HDI Categories",
       y = "Tax")+theme_bw()

# Choose the dependent variable HDI
dependent_variable <- "hdi"

# Create scatterplots
par(mfrow = c(1, 2))  # Setting up a 1x2 grid for the plots

# Scatterplot for HDI vs. Population with Line of Best Fit
plot(complete_df$population, complete_df[[dependent_variable]], main = paste(dependent_variable, "vs. Population"), xlab = "Population", ylab = dependent_variable)
abline(lm(complete_df[[dependent_variable]] ~ complete_df$population), col = "red")

# Scatterplot for HDI vs. Tax with Line of Best Fit
plot(complete_df$tax, complete_df[[dependent_variable]], main = paste(dependent_variable, "vs. Tax"), xlab = "Tax", ylab = dependent_variable)
abline(lm(complete_df[[dependent_variable]] ~ complete_df$tax), col = "red")

# Resetting the plotting layout
par(mfrow = c(1, 1))

# Correlation Analysis
corr <- cor(complete_df[colsnum])
corr
str(complete_df)


# Regression Analysis
# This creates a simple linear regression model where hdi is the outcome variable 
#and tax is the predictor variable. .
model_tax <- lm(hdi ~ tax, data = complete_df)

# Assess the model
summary(model_tax)
#RSE of a model
sigma(model_tax)
res_tax <- resid(model_tax)

# Using the population as the predictor variable.
model_pop <- lm(hdi ~ population , data = complete_df)
summary(model_pop)
sigma(model_pop)
res_pop <- resid(model_pop)

# Using the population as the predictor variable.
model_3 <- lm(hdi ~ population + tax , data = complete_df)
summary(model_3)
sigma(model_3)
res_3 <- resid(model_3)

# Create a multi-panel plot
par(mfrow = c(1, 2))

# 1. Residuals vs. Fitted
plot(model_tax, which = 1, main = "Residuals vs. Fitted")

# 2. QQ Plot
qqnorm(residuals(model_tax))
qqline(residuals(model_tax))

par(mfrow = c(2, 2))
plot(model_3)

# Add a main title using mtext
mtext("Residual Analysis for Linear Regression Model", side = 3, line = 1, outer = TRUE)

# Reset the graphics parameters
par(mfrow = c(1, 1))
str(complete_df)

## Hypothesis testing


# Perform ANOVA
anova_result <- aov(tax ~ hdi_category, data = complete_df)
# Perform two-way ANOVA
anova_result2 <- aov(cbind(tax, population) ~ hdi_category, data = complete_df)

# Display ANOVA results
summary(anova_result)
summary(anova_result2)



# Perform Kruskal-Wallis test to compare tax between different HDI categories
kruskal.test(tax ~ hdi_category, data = complete_df)


# As the test shows significance, perform the Wilcoxon rank-sum  test
# we will do perform a post-hoc tests to identify which specific groups differ from each other
pairwise.wilcox.test(complete_df$tax,complete_df$hdi_category, 
                     p.adjust.method = "bonferroni")
