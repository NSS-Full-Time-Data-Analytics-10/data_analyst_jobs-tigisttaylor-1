SELECT *
FROM data_analyst_jobs;

-- QUESTION 1:How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs
-- There are 1793 rows

-- QUESTION 2:Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--ExxonMobil

-- QUESTION 3:How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location='TN'
--There are 21 in TN
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location='TN' OR location='KY'
--There are 27 in both


-- QUESTION 4:How many postings in Tennessee have a star rating above 4?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location='TN'AND star_rating>4;

-- QUESTION 5:How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--There are 151

-- QUESTION 6:Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT NULL 
	AND location !='USA' 
	AND location !='DC' 
	AND location !='REMOTE'
GROUP BY state
ORDER BY avg_rating DESC;

-- QUESTION 7:Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
--There are 881 unique job titles

-- QUESTION 8:How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title) AS unique_job_titles
FROM data_analyst_jobs
WHERE location='CA';
--There are 230 unique job titles for CA

-- QUESTION 9:Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating) 
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
	HAVING SUM(review_count)>5000
--70 companies have a avg star rating of over 5000


-- QUESTION 10:Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count)>5000
ORDER BY avg_star_rating DESC;
--Google had the highest avg star rating with a rating of 4.3000001910000000

-- QUESTION 11:Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
SELECT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'
--	There are 1669 different job titles

-- QUESTION 12:How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
			AND title NOT ILIKE '%Analytics%';
--They all have the word Tableau



--*BONUS* You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
SELECT domain, COUNT(title) AS hard_to_fill_jobs
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'
		AND days_since_posting >21
		AND domain IS NOT NULL
GROUP BY domain
ORDER BY hard_to_fill_jobs DESC;