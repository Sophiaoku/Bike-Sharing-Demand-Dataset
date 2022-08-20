# Kaggle---Bike-Sharing-Demand
Predicting total rented by the hour

Kaggle - Submissions are evaluated one the Root Mean Squared Logarithmic Error (RMSLE).

datetime - hourly date + timestamp 

season -  1 = spring, 2 = summer, 3 = fall, 4 = winter 

holiday - whether the day is considered a holiday

workingday - whether the day is neither a weekend nor holiday

weather - 1: Clear, Few clouds, Partly cloudy, Partly cloudy
2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist
3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds
4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog 

temp - temperature in Celsius

atemp - "feels like" temperature in Celsius

humidity - relative humidity

windspeed - wind speed

casual - number of non-registered user rentals initiated

registered - number of registered user rentals initiated

count - number of total rentals

Step 1 - Process the data  

I started by looking for trends and relationships between variables in the provided dataset by calling a few functions in R (Str, summary and head). All variables except the Datetime were in a numerical class. Converted the datetime colomn using the Posxit function. 
I also noticed a few variables such as atemp (you really can't predict this unlike the actual temp) and Holiday ( similar trends to working day)

Step 2 - Generate a hypothesis 

Hourly trend: 

Daily Trend: 

Rain: 

Temperature: 

Pollution: 

Traffic: 
