/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

Select *
From PortfolioProject.coviddeaths
Where continent is not null 
order by 3,4;

-- Select data that we are going to be starting with

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject.coviddeaths
Where continent is not null 
order by 1,2;


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject.coviddeaths
Where location like '%states%'
and continent is not null 
order by 1,2;


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject.coviddeaths
Where location like '%states%'
order by 1,2;


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject.coviddeaths
Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc;


-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as double)) as TotalDeathCount
From PortfolioProject.coviddeaths
Where location like '%states%'
&& continent is not null 
Group by Location
order by TotalDeathCount desc;


-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as double)) as TotalDeathCount
From PortfolioProject.coviddeaths
Where location like '%states%'
or continent is not null 
Group by continent
order by TotalDeathCount desc;

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as double)) as total_deaths, SUM(cast(new_deaths as double))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject.coviddeaths
Where location like '%states%'
&& continent is not null 
Group By date
order by 1,2;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT 
  dea.continent, 
  dea.location, 
  dea.date, 
  dea.population, 
  vac.new_vaccinations,
  SUM(CAST(vac.new_vaccinations AS UNSIGNED)) 
    OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated,
  (SUM(CAST(vac.new_vaccinations AS UNSIGNED)) 
    OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) / dea.population) * 100 
    AS PercentVaccinated
FROM PortfolioProject.coviddeaths dea
JOIN PortfolioProject.covidvaccinations vac
  ON dea.location = vac.location 
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3;

-- Using CTE to perform Calculation on Partition By in previous query

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS (
  SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS UNSIGNED)) 
      OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
  FROM PortfolioProject.coviddeaths dea
  JOIN PortfolioProject.covidvaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL 
  ORDER BY 2, 3
)
SELECT *, (RollingPeopleVaccinated / Population) * 100
FROM PopvsVac;

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS PercentPopulationVaccinated;

CREATE TABLE PercentPopulationVaccinated (
  Continent VARCHAR(255) CHARACTER SET utf8mb4,
  Location VARCHAR(255) CHARACTER SET utf8mb4,
  Date DATETIME,
  Population NUMERIC,
  New_vaccinations NUMERIC,
  RollingPeopleVaccinated NUMERIC
);

INSERT INTO PercentPopulationVaccinated
SELECT 
  dea.continent, 
  dea.location, 
  dea.date, 
  dea.population, 
  CAST(vac.new_vaccinations AS UNSIGNED) AS New_vaccinations,
  SUM(CAST(vac.new_vaccinations AS UNSIGNED)) 
    OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM (
  SELECT * FROM PortfolioProject.coviddeaths WHERE continent IS NOT NULL
) dea
JOIN (
  SELECT * FROM PortfolioProject.covidvaccinations WHERE continent IS NOT NULL
) vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE vac.new_vaccinations REGEXP '^[0-9]+$'
ORDER BY 2, 3;

SELECT *, (RollingPeopleVaccinated / Population) * 100
FROM PercentPopulationVaccinated;


-- Creating View to store data for later visualizations

DROP TABLE IF EXISTS PercentPopulationVaccinated;

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
  dea.continent, 
  dea.location, 
  dea.date, 
  dea.population, 
  vac.new_vaccinations,
  SUM(CAST(vac.new_vaccinations AS UNSIGNED)) 
    OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated,
  (SUM(CAST(vac.new_vaccinations AS UNSIGNED)) 
    OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) / dea.population) * 100 
    AS PercentVaccinated
FROM PortfolioProject.coviddeaths dea
JOIN PortfolioProject.covidvaccinations vac
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
  AND dea.location NOT IN (
    'Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania', 'World'
  );


