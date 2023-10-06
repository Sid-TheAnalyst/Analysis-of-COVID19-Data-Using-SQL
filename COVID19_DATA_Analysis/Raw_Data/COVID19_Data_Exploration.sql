
-- Selecting the required columns for further analysis
SELECT location,population,date,total_cases,new_cases,total_deaths
FROM COVID19.dbo.CovidDeaths
ORDER BY 1,2

-- Checking the datewise death %
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
FROM COVID19.dbo.CovidDeaths
WHERE continent is not NULL
ORDER BY 1,2

-- Checking the infection %
SELECT location,date,population,total_cases,(total_cases/population)*100 AS InfectedPercentage
FROM COVID19.dbo.CovidDeaths
WHERE continent is not NULL
ORDER BY 1,2

-- Checking country wise infection rate
SELECT location,MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population)*100) AS InfectedPercentage
FROM COVID19.dbo.CovidDeaths
WHERE continent is not NULL
GROUP BY location
ORDER BY 2 DESC

-- Country wise death count
SELECT location,MAX(cast(total_deaths as int)) AS TotalDeaths
FROM COVID19.dbo.CovidDeaths
WHERE continent is not NULL
GROUP BY location
ORDER BY 2 DESC

-- Continent wise death count
SELECT location,MAX(cast(total_deaths as int)) AS TotalDeaths
FROM COVID19.dbo.CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY 2 DESC
