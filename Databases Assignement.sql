-- Question 1 : Count how many cities are there in each country? -- 
SELECT co.Name      AS Country,
       COUNT(ci.ID) AS CityCount
FROM country co
JOIN city ci
  ON ci.CountryCode = co.Code
GROUP BY co.Code, co.Name
ORDER BY CityCount DESC;


-- Question 2 : Display all continents having more than 30 countries. 
 SELECT Continent,
       COUNT(*) AS CountryCount
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

-- Question 3 : List regions whose total population exceeds 200 million. 

select region, sum(population) 
from country 
group by region 
having sum(population) > 200000000;

-- Question 4 : Find the top 5 continents by average GNP per country. 
select continent, avg(gnp) as avg_gnp 
from country group by continent  
order by avg_gnp desc Limit 5;

-- Question 5 : Find the total number of official languages spoken in each continent.

select * from country;
select * from countrylanguage;

select continent, count(distinct Language) from country join countrylanguage on country.code = countrylanguage.CountryCode
 where countrylanguage.IsOfficial ='T'
group by continent;

-- Question 6 : Find the maximum and minimum GNP for each continent.

select continent, max(GNP) as maxgnp , min(GNP) as mingnp from country
group by continent;

-- Question 7 : Find the country with the highest average city population.
select * from city;
select * from country;

select country.Name, avg(city.Population) as avg_city_population 
from country join city on country.code = city.countrycode 
group by country.Name
ORDER BY avg_city_population DESC
LIMIT 1;

-- Question 8 : List continents where the average city population is greater than 200,000.

SELECT country.Continent,
       AVG(city.Population) AS avg_city_population
FROM city
JOIN country ON city.CountryCode = country.Code
GROUP BY country.Continent
HAVING AVG(city.Population) > 200000;


-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life
-- expectancy descending.

SELECT Continent,
       SUM(Population) AS total_population,
       AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
GROUP BY Continent
ORDER BY avg_life_expectancy DESC;

-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
-- total population is over 200 million.

SELECT Continent,
       total_population,
       avg_life_expectancy
FROM (
      SELECT Continent,
             SUM(Population) AS total_population,
             AVG(LifeExpectancy) AS avg_life_expectancy
      FROM country
      GROUP BY Continent
     ) AS t
WHERE total_population > 200000000
ORDER BY avg_life_expectancy DESC
LIMIT 3;
