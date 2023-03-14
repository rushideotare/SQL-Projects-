/*


Business model Customer to Customer (C2C) allows customers to do business with each other. This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and buyer can buy it without paying anything. E-Commerce website brings the seller and buyer to the same platform. 

Analyzing the user's database will lead to understanding the business perspective. Behaviour of the users can be traced in terms of business with exploration of the user’s database. 

Dataset: One .csv file with name users_data with 98913 rows and 27 columns

Tasks to be performed

Create new schema as users_data
Import .csv file users_data into MySQL
(right click on users_data schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)
Run SQL command to see the structure of table
Run SQL command to select first 100 rows of the database
How many distinct values exist in table for field country and language
Check whether male users are having maximum followers or female users.
Calculate the total users those
Uses Profile Picture in their Profile
Uses Application for users_data platform
Uses Android app
Uses ios app
Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.)
Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.)
Display name of top 10 countries having maximum products pass rate.
Calculate the number of users on an users_data platform for different language choices.
Check the choice of female users about putting the product in a wishlist or to like socially on an users_data platform. (Hint: use UNION to answer this question.)
Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
Which country is having maximum number of buyers?
List the name of 10 countries having zero number of sellers.
Display record of top 110 users who have used users_data platform recently.
Calculate the number of female users those who have not logged in since last 100 days.
Display the number of female users of each country at users_data platform.
Display the number of male users of each country at users_data platform.
Calculate the average number of products sold and bought on users_data platform by male users for each country.

*/

 # 1
create database if not exists ecommerce;

#2
use ecommerce;

# 3  
describe users_data;

# 4  
SELECT 
    *
FROM
    users_data
LIMIT 100;

# 5 
SELECT 
    COUNT(DISTINCT country) distinct_values_exist_in_table_for_field_country
FROM
    users_data;
SELECT 
    COUNT(DISTINCT language) distinct_values_exist_in_table_for_field_country
FROM
    users_data;
SELECT 
    COUNT(DISTINCT country, language) distinct_values_exist_in_table_for_field_country_And_Language
FROM
    users_data;


# 6  
select count(if (gender='M',1,null) ) Male_Users from users_data;
select count(if (gender='F',1,null) ) Male_Users from users_data;

# 7 

SELECT 
    count(hasProfilePicture) Uses_Profile_Picture_in_their_Profile 
FROM
    users_data where hasProfilePicture='True';
    
select count(hasAnyApp) Uses_Application_for_users_data_Platform 
from users_data where hasAnyApp='True';

select count(hasAndroidApp) Uses_Android_App 
from users_data where hasAndroidApp='True';

select count(hasIosApp) Uses_ios_app 
from users_data where hasIosApp='True';


# 8 

SELECT 
    productsBought total_number_of_buyers, country
FROM
    users_data
WHERE
    productsBought > 0
group by country
ORDER BY productsBought  DESC;




# 9 

SELECT 
    productsSold total_number_of_sellers, country
FROM
    users_data
WHERE
    productsSold > 0
group by country
ORDER BY productsSold ASC;

# 10 

SELECT 
    country, productsPassRate name_of_top_10_countries 
FROM
    users_data
ORDER BY productsPassRate DESC
LIMIT 10;

# 11  

SELECT 
    language, COUNT(language) different_language_choices
FROM
    users_data
GROUP BY language;



# 12

SELECT 
    gender, productsWished  product_in_a_wishlist 
FROM
    users_data
WHERE
    gender = 'F' 
UNION SELECT 
    gender, socialProductsLiked 
FROM
    users_data
WHERE
    gender = 'F';


# 13 
SELECT 
    gender, productsWished choice_of_male_users_about_being_seller_or_buyer
FROM
    users_data
WHERE
    gender = 'M' 
UNION SELECT 
    gender, socialProductsLiked
FROM
    users_data
WHERE
    gender = 'M';


# 14 
SELECT 
    country, MAX(productsBought)  country_is_having_maximum_number_of_buyers,count(productsBought) Count_number_of_buyers
FROM
    users_data ;

# 15  
SELECT 
    country, productsSold name_of_10_countries_having_zero_number_of_sellers
FROM
    users_data
WHERE
    productsSold = 0
LIMIT 10;
 
#16  
SELECT 
    daysSinceLastLogin User_days_Since_Last_Login
FROM
    users_data
ORDER BY daysSinceLastLogin ASC
LIMIT 110;


# 17  

SELECT 
    count(gender) number_of_female_users  , gender
FROM
    users_data
WHERE
    gender = 'F'
        AND daysSinceLastLogin > 100
ORDER BY daysSinceLastLogin
LIMIT 110;


# 18  
SELECT 
    COUNT(gender)  number_of_female_users, country
FROM
    users_data
WHERE
    gender = 'F'
GROUP BY country;

# 19 

SELECT 
    COUNT(gender) number_of_female_users, country
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;



# 20  

SELECT 
    *
FROM
    users_data;

SELECT 
    AVG(productsSold) average_number_of_products_sold,
    AVG(productsBought) average_number_of_products_bought, 
    COUNT(gender) Number_Of_male_users ,
    country
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;
 












