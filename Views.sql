use[Covid19_A2]
go

DROP VIEW IF EXISTS vwCases_per10000
GO


--Creating the views

--Case View
CREATE VIEW vwCases_per10000 AS 

select ((MAX([cumulative_cases])/ p.[Population])* 10000) rel_prop_cases_per10000, p.[Province]
FROM [dbo].[Cases] Cases 
INNER JOIN 
[dbo].[Province_Population] p 
ON Cases.province = p.Province
GROUP BY
p.Population, p.Province

GO

--Deaths View
DROP VIEW IF EXISTS vwDeaths_per10000
GO

CREATE VIEW vwDeaths_per10000 AS 

select ((MAX([cumulative_deaths])/ p.[Population])* 10000) rel_prop_deaths_per10000, p.[Province]
FROM [dbo].[Deaths] Deaths
INNER JOIN 
[dbo].[Province_Population] p 
ON Deaths.province = p.Province
GROUP BY
p.Population, p.Province

GO

--fully_Vaccinated View
DROP VIEW IF EXISTS vwCVaccines_per10000
GO

CREATE VIEW vwCVaccines_per10000 AS 

select ((MAX([cumulative_cvaccine])/ p.[Population])* 10000) rel_prop_cVaccines_per10000, p.[Province]
FROM [dbo].[Vaccines] Vaccines
INNER JOIN 
[dbo].[Province_Population] p 
ON Vaccines.province = p.Province
GROUP BY
p.Population, p.Province

GO

--SummaryView
DROP VIEW IF EXISTS vwSummary
GO

CREATE VIEW vwSummary AS

select m,y,labelDt,MAX(cases) cases,MAX(deaths) deaths, MAX(recovered) recovered 
FROM( 
SELECT
month(Cumulative_Cases.[date_active]) m,
YEAR(Cumulative_Cases.[date_active]) y,
datename (MONTH, Cumulative_Cases.[date_active])+'-'+ datename(YEAR, Cumulative_Cases.[date_active]) labelDt,

[dbo].[Cumulative_Cases].[cumulative_cases] Cases,
[dbo].[Cumulative_Cases].[cumulative_deaths] Deaths,
[dbo].[Cumulative_Cases].[cumulative_recovered] Recovered

FROM [dbo].[Cumulative_Cases]
)summary
GROUP BY
summary.m , summary.y, summary.labelDt

GO