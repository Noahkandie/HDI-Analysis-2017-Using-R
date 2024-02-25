# HDI Analysis 2017

## Overview

This repository contains code and documentation for analyzing the Human Development Index (HDI) for the year 2017, focusing on the impact of population growth and tax revenue percent of GDP on the HDI of countries worldwide.

## Table of Contents

1. [Introduction](#introduction)
2. [Data](#data)
3. [Data Preprocessing](#data-preprocessing)
4. [Exploratory Data Analysis](#exploratory-data-analysis)
5. [Linear Regression Modeling](#linear-regression-modeling)
6. [Hypothesis Testing](#hypothesis-testing)
7. [Non-Parametric Tests](#non-parametric-tests)
8. [Conclusion](#conclusion)
9. [Recommendations](#recommendations)
10. [Contributing](#contributing)
11. [Issues](#issues)
12. [License](#license)

## Introduction

The Human Development Index (HDI) serves as a comprehensive measure, reflecting a country's overall development based on factors such as life expectancy, education, and per capita income. The analysis for 2017 explores the impact of population growth and tax revenue percent of GDP on HDI globally.

## Data

Datasets include HDI, Tax, and Population datasets sourced from GapMinder repositories. The 2017 tax rate displays a symmetrical bell-shaped curve around the mean, ranging between 0 and 35%. The population growth histogram reveals a normal distribution with a mean around 1%, with some countries experiencing negative growth rates.

## Data Preprocessing

![image](https://github.com/Noahkandie/HDI-Analysis-2017-Using-R/assets/83200580/125d1d43-5778-4810-b054-f88d24a602aa)


Steps involve merging relevant columns, detecting outliers, and handling missing values. The HDI column is encoded, resulting in a clean dataset with variables such as country, tax rate, population growth rate, and HDI.

## Exploratory Data Analysis
![image](https://github.com/Noahkandie/HDI-Analysis-2017-Using-R/assets/83200580/6f695a2b-cc15-4ae3-8327-cfd197a5789a)


The HDI distribution histogram shows two contrasting groups, indicating two categories of countries in terms of development. The correlation matrix reveals weak to moderate correlations, with tax and HDI showing a weak positive correlation, population and HDI a moderate negative correlation, and tax and population a weak negative correlation.

## Linear Regression Modeling
![image](https://github.com/Noahkandie/HDI-Analysis-2017-Using-R/assets/83200580/082d3f94-236a-45a6-86c5-deae7b4c1103)


![image](https://github.com/Noahkandie/HDI-Analysis-2017-Using-R/assets/83200580/35fa3fb8-d136-4dac-8ad9-8b5df6db9927)


Linear regression models for tax and population as predictors of HDI show statistical significance. The coefficient for tax suggests a positive association with HDI, while the coefficient for population implies a negative impact. Diagnostic plots indicate potential nonlinearity.

## Hypothesis Testing

Hypothesis testing confirms the significance of tax and population in explaining HDI variability. Both ANOVA and non-parametric tests reject null hypotheses, indicating a significant difference in means across different levels of HDI category for tax and population.

## Non-Parametric Tests

Kruskal-Wallis and Wilcoxon tests further validate the significance of tax categories on HDI, supporting the findings from linear regression and ANOVA.

## Conclusion

Analysis reveals that tax rates and population growth are associated with variations in HDI. Although statistically significant, linear regression models have relatively low R-squared values, suggesting limited explanatory power. Hypothesis testing confirms the significance of both tax and population in explaining HDI variability.

## Recommendations

1. **Policy Implications:**
   - Governments with higher tax rates may consider policies that promote sustainable development.
   - Countries experiencing high population growth might benefit from policies aimed at addressing associated challenges.

2. **Further Research:**
   - Explore additional factors influencing HDI to enhance predictive models.
   - Investigate the impact of specific tax policies and population management strategies on development outcomes.

3. **Data Enrichment:**
   - Obtain more recent and comprehensive data, including more variables, for a more accurate analysis.
   - Consider additional socioeconomic indicators to capture a broader scope of development.

## Contributing

Contributions are welcome! Please fork the repository, create a new branch, and submit a pull request.

## Issues

Report any issues or bugs in the [Issues](https://github.com/username/HDI-Analysis-2017/issues) section.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
