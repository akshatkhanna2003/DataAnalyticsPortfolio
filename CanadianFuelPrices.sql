--Name: Akshat Khanna

-- The dataset analyzed in this file are from Statistics Canada
-- The Data is retrived from:
-- Statistics Canada. Table 18-10-0001-01  Monthly average retail prices for gasoline and fuel oil, by geography
-- DOI: https://doi.org/10.25318/1810000101-eng

-- Displays the entire data set for regular gas
SELECT * FROM PortfolioProject..RegularGasData

-- Displays the entire data set for premium gas
SELECT * FROM PortfolioProject..PremiumGasData

-- Only displays the essential information for regular gas

SELECT REF_DATE, GEO, [Type of fuel], UOM, VALUE 
FROM PortfolioProject..RegularGasData

-- Only displays the essential information for premium gas

SELECT REF_DATE, GEO, [Type of fuel], UOM, VALUE 
FROM PortfolioProject..PremiumGasData

-- Displays the lowest value and highest values for regular gas recorded in each location, as well as the difference as a percentage of these values

SELECT GEO, MIN(VALUE) as [Regular Gas Lowest Value], MAX(VALUE) as [Regular Gas Highest Value], ((MAX(VALUE)-MIN(VALUE))/(((MAX(VALUE)+MIN(VALUE))/2)))*100 as [Difference in Percentage] 
FROM PortfolioProject..RegularGasData GROUP BY GEO

-- Displays the lowest and highest values for premium gas in each location, including the difference as a percentage between these two values

SELECT GEO, MIN(VALUE) as [Premium Gas Lowest Value], MAX(VALUE) as [Premium Gas Highest Value], ((MAX(VALUE)-MIN(VALUE))/(((MAX(VALUE)+MIN(VALUE))/2)))*100 as [Difference in Percentage] 
FROM PortfolioProject..PremiumGasData 
GROUP BY GEO

-- Displays the the value of premium fuel in descending order

SELECT REF_DATE, GEO, [Type of fuel], VALUE 
FROM PortfolioProject..PremiumGasData 
ORDER BY VALUE desc

-- Displays the value of regular fuel in descending order

SELECT REF_DATE, GEO, [Type of fuel], VALUE 
FROM PortfolioProject..RegularGasData 
ORDER BY VALUE desc

-- Compares the highest price of regular fuel to the highest price of premium fuel in each location

SELECT PortfolioProject..RegularGasData.GEO, MAX(PortfolioProject..RegularGasData.VALUE) as [Highest Price of Regular Fuel], MAX(PortfolioProject..PremiumGasData.VALUE) as [Highest Price of Premium Fuel] 
FROM PortfolioProject..RegularGasData 
JOIN PortfolioProject..PremiumGasData 
ON PortfolioProject..RegularGasData.GEO = PortfolioProject..PremiumGasData.GEO 
GROUP BY PortfolioProject..RegularGasData.GEO

-- Compares the lowest price of regular fuel to the lowest price of premium fuel in each location

SELECT PortfolioProject..RegularGasData.GEO, MIN(PortfolioProject..RegularGasData.VALUE) as [Lowest Price of Regular Fuel], MIN(PortfolioProject..PremiumGasData.VALUE) as [Lowest Price of Premium Fuel] 
FROM PortfolioProject..RegularGasData 
JOIN PortfolioProject..PremiumGasData 
ON PortfolioProject..RegularGasData.GEO = PortfolioProject..PremiumGasData.GEO 
GROUP BY PortfolioProject..RegularGasData.GEO

-- Show how the prices of regular fuel in canada have changed over time

SELECT REF_DATE, GEO, VALUE 
FROM PortfolioProject..RegularGasData 
WHERE GEO LIKE '%Canada%'

-- Query below shows the price of regular and premium fuel through time for different locations, uncomment the next comment and the last line to create and display the view labelled "FuelPricesAcrossCanada".
-- This should be done by selecting the code starting at the create view line till the end of the document.

--CREATE VIEW FuelPricesAcrossCanada as
SELECT PortfolioProject..RegularGasData.REF_DATE, PortfolioProject..RegularGasData.GEO, PortfolioProject..RegularGasData.VALUE as [Regular Fuel Value], PortfolioProject..PremiumGasData.VALUE as [Premium Fuel Value] 
FROM PortfolioProject..RegularGasData 
JOIN PortfolioProject..PremiumGasData 
ON PortfolioProject..RegularGasData.REF_DATE = PortfolioProject..PremiumGasData.REF_DATE and PortfolioProject..RegularGasData.GEO = PortfolioProject..PremiumGasData.GEO

--SELECT * FROM FuelPricesAcrossCanada