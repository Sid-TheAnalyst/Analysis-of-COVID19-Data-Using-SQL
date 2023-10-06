-- Select all columns
SELECT *
FROM COVID19.dbo.CovidDeaths

-- Get the day_wise_death_percentage_for_Country_India
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS deathpercentage
FROM COVID19.dbo.CovidDeaths
WHERE location = 'India'

-- Top countries with the highest total cases
SELECT location,population,
MAX(CAST(total_cases as INT)) as TotalCases,
MAX(CAST(total_deaths as INT)) as TotalDeaths,
(MAX(CAST(total_cases as INT))/population)*100 as PercentagePopulationInfected,
(MAX(CAST(total_deaths as INT))/population)*100 as PercentagePopulationDead
FROM COVID19.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY TotalCases DESC

-- Continent wise highest death count

SELECT continent,MAX(CAST (total_deaths as int)) as TotalDeaths
FROM COVID19.dbo.CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeaths DESC

/* Create an Temp Table to store the Percentage of 
population vaccinated for each country*/

DROP TABLE IF EXISTS
CREATE TABLE #PercentagePopulationVaccinated
(
location nvarchar(255),
population int,
Total_cases int,
Total_vaccinations int,
VaccinationPercentage float
)
INSERT INTO #PercentagePopulationVaccinated
SELECT deaths.location,deaths.population,
MAX(CAST(deaths.total_cases AS INT)) AS TotalCases,
MAX(CAST(vaccin.total_vaccinations AS INT)) AS TotalVaccinations,
MAX(CAST(vaccin.total_vaccinations AS INT))/population*100 as VaccinationPercentage
FROM COVID19.dbo.CovidDeaths AS deaths
JOIN COVID19.dbo.CovidVaccinations AS vaccin
	ON deaths.location = vaccin.location
	AND deaths.date = vaccin.date
WHERE deaths.continent is not null
GROUP BY deaths.location,deaths.population
ORDER BY VaccinationPercentage DESC

SELECT *
FROM #PercentagePopulationVaccinated
ORDER BY VaccinationPercentage DESC








