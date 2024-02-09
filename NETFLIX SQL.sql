USE [NETFLIX PROJECT]

Select *
FROM [dbo].['Netflix Data$']

# List the Top 10 Movies With the Highest Average Rating

Select TOP 10 title, AVG(IMDB_SCORE) AS Avg_rating
From 
GROUP By TITLE
ORDER BY Avg_Rating DESC;


# Calculate the Percentage of Movie that Belong to each Genre in the Database

Select Genre, Count(*) AS Movie_Count,(COUNT(*)*100.0)/(Select Count(*) From ['Netflix Data$']) AS percentage
FROM ['Netflix Data$']
Group by Genre
Order By Percentage DESC;

# Rank the Movie & Tv Series on the Basis of their IMDB Score .

Select Title, IMDB_SCORE, RANK() OVER (ORDER BY IMDB_SCORE DESC) AS Rnk
FROM ['Netflix Data$']

# Find which Country Have the Highest & Lowest Movie Make .

Select PRODUCTION_COUNTRIES , max(Tv_series_Count) AS Max_Tv_series_Count, Min(Tv_series_Count) AS  Min_Tv_series_count
From (
Select Production_countries, Count(*) As Tv_series_count
FROM ['Netflix Data$']
GROUP BY PRODUCTION_COUNTRIES
) AS Tv_series_Count ;

# Find the Average Rating for the Movie that Belong to Mutiple Genres .

Select Genre , Avg(IMDB_SCORE) As AVG_Rating
FROM ['Netflix Data$']
GROUP BY GENRE
Order By Avg_Rating DESC;


# Categories the Genre on the According to Age-Certification . 

Select 
	Case
	  When Age_Certification<= 'PG' THEN 'Children'
	  When Age_Certification= 'PG-13' THEN 'Teen'
	  When Age_Certification IN('R', 'TV-MA') THEN 'Adult'
ELSE 'UNKNOWN'
END As Age_Category, Genre,
Count(*) AS Genre_count
From ['Netflix Data$']
Group By AGE_CERTIFICATION, GENRE ;

# Find the 2nd Highest Movie that are Made in the Year 2022 .

Select Title, IMDB_SCORE
From ['Netflix Data$']
Where RELEASE_YEAR=2022 AND IMDB_SCORE=( SELECT Max(IMDB_SCORE)
FROM ['Netflix Data$']
Where RELEASE_YEAR=2022 AND IMDB_SCORE<(SELECT MAX(IMDB_SCORE)
FROM ['Netflix Data$']
Where RELEASE_YEAR=2022
)
);

