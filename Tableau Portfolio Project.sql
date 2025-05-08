/*

Queries used for Tableau Project

*/

-- 1. 

SELECT 
  ROUND(SUM(new_cases), 0) AS total_cases,
  ROUND(SUM(new_deaths), 0) AS total_deaths,
  ROUND(SUM(new_deaths) / SUM(new_cases) * 100, 2) AS DeathPercentage
FROM PortfolioProject.coviddeaths
WHERE continent IS NOT NULL
  AND location NOT IN (
    'World', 'Africa', 'Asia', 'Europe',
    'North America', 'South America', 'Oceania',
    'European Union', 'International'
  )
  AND new_cases >= 0
  AND new_deaths >= 0;

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location

SELECT location, SUM(CAST(new_deaths AS DOUBLE)) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

SELECT 
  location AS location,
  SUM(new_deaths) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE location IN (
  'Africa', 'Asia', 'Europe',
  'North America', 'South America', 'Oceania'
)
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject.coviddeaths
Group by Location, Population
order by PercentPopulationInfected desc;


-- 4.


Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject.coviddeaths
Group by Location, Population
order by PercentPopulationInfected desc;








