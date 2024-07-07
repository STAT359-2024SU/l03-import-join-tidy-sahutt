# L03-import-join-tidy ----


## load packages ----

library(tidyverse)
library(nycflights13)

## Exercises ----

# Ex 1 --- ----------------------------------------------------------------

#Demonstrate how to read in `TopBabyNamesByState.txt` contained in the `data` 
#sub-directory using the appropriate function from the `readr` package. 
#After reading in the data, determine the top male and female names in 
#1984 for South Dakota.


top_baby_names <- read_delim("data/TopBabyNamesbyState.txt",
                             show_col_types = FALSE)

top_baby_names |>
  filter(state == 'SD', year == 1984) 


# Ex 3 --------------------------------------------------------------------

#Practice referring to non-syntactic names in the following data frame by:


# toy dataset

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`)))

#a.  Extracting the variable called 1.
#b.  Plotting a scatterplot of 1 vs 2.
#c.  Creating a new column called 3 which is 2 divided by 1.
#d.  Renaming the columns to one, two and three.

#a. 

annoying[ , 1]

#b.

annoying |> 
  ggplot(aes(x = `2`, y = `1`)) +
  geom_point()

#c.

annoying |> 
  mutate('3' = `2`/`1`)

#d. 
annoying |> 
  mutate('3' = `2`/`1`) |>  
  rename( one = `1`, two = `2`, three = '3')


# Ex 5 --------------------------------------------------------------------

#  | price | store   | ounces |
#  |-------|---------|--------|
#  | 3.99  | target  | 128    |
#  | 3.75  | walmart | 128    |
#  | 3.00  | amazon  | 128    |

tibble(
  price = c(3.99, 3.75, 3.00),
  store = c("target", "walmart", "amazon"),
  ounces = c(128, 128, 128))

tribble(
  ~price, ~store, ~ounces,
  3.99, "target", 128,
  3.75, "walmart", 128,
  3.00, "amazon", 128)


# Ex 8 --------------------------------------------------------------------

#loaded nycflights13 package

#What weather conditions make it more likely to see a departure delay? 
#Hint: Join the two appropriate datasets together, then determine how 
#weather impacts departures.

flights
weather

#join_by origin, time? see what default does

flights_weather <- weather |> 
  left_join(flights)  
  #by = join_by(origin, year, month, day, hour, time_hour)
  
flights_weather |> select(temp:visib, dep_delay)  |> 
  arrange(desc(dep_delay))


# Ex 10 -------------------------------------------------------------------

# Tidy the simple tibble of [M&M](https://en.wikipedia.org/wiki/M%26M%27s) 
# data below and drop the NA values.

# Do you need to make it wider or longer? What are the variables in your 
# tidy version? What argument drops the NA values?

# simple tibble of M&M data
mm_data <- tribble(
  ~mm_type, ~blue, ~orange,	~green,	~yellow, ~brown, ~red, ~cyan_blue,
  "plain",  6,     18,      12,	    6,       7,	     7,    NA,
  "peanut", NA,	   11,	    9,	    1,	     12,	   8,    15
)

mmtidy <- mm_data |> 
  pivot_longer(cols = !mm_type, 
               names_to = "color",
               values_to = "count",
               values_drop_na = TRUE) |> 
  knitr::kable()


# Ex 11 -------------------------------------------------------------------

# Recreate the following table from table4a with only pivot longer 

#Note: table4a does not exist in the readings, the videos, or the html
#googled and found it in a previous edition of the textbook

#Recreate this:
# A tibble: 6 × 3
# country      year  cases
# <chr>       <int>  <int>
# 1 Afghanistan  1999    745
# 2 Afghanistan  2000   2666
# 3 Brazil       1999  37737
# 4 Brazil       2000  80488
# 5 China        1999 212258
# 6 China        2000 213766

#From this:
# table4a

#> # A tibble: 3 x 3
#>   country     `1999` `2000`
#> * <chr>        <int>  <int>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766

table4a <- tribble(
  ~"country", ~"1999", ~"2000",
  "Afghanistan", 745, 2666,
  "Brazil", 37737, 80488,
  "China", 212258, 213766) 

tidy_table4a <- table4a |> 
  pivot_longer(cols = !country,
               names_to = "year",
               values_to = "cases")


# Ex 12 -------------------------------------------------------------------

# What happens if you use `pivot_wider()` on this table so that we have a 
# dataset with 3 columns (`respondent_name`, `age`, `height`) and why? 

# Fix the issue by adding a new column.

people <- tribble(
  ~respondent_name,  ~key,    ~value,
  #-----------------|--------|------|
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

people |> pivot_wider(names_from = key,
                      values_from = value)

people2 <- tribble(
  ~respondent_name,  ~key,    ~value, ~ID,
  #-----------------|--------|------|-----|
  "Phillip Woods",   "age",       45, 1,
  "Phillip Woods",   "height",   186, 1,
  "Phillip Woods",   "age",       50, 2,
  "Jessica Cordero", "age",       37, 3,
  "Jessica Cordero", "height",   156, 3
)

people2 |> pivot_wider(names_from = key,
                      values_from = value)


# Case Study --------------------------------------------------------------

# Tinder is interested in knowing more about their most active users and have 
# tasked you with exploring their 7 most active users during 2020. The dataset 
# containing the top 7 active users during 2020 is stored in the `data` folder 
# and called `users_top7_2020.csv`.^[This dataset was sourced from 
# [Swipestats.io](https://www.swipestats.io/).]

# The column names contain prefixes "matches", "likes", and "passes" followed 
# by a number; the suffix number represents the month; and the cell represents 
# either the total number of matches (matches), total number of times the user 
# swiped right (likes), or total number of times the user swiped left (passes) 
# during that month (ie: `matches_1` = total number of matches during January 
# 2020).

#Complete the following tasks:
  
# a)  Use an appropriate readr function to read in `users_top7_2020.csv`

# b)  Is `users_top7_2020.csv` a `tibble` and how do you know? If it isn't, 
# then figure how to turn it into a `tibble`.

# c) `Use an appropriate graph to visualize the matches, likes, and passes 
# over time for each user. What insights and conclusions can you gain from 
# this graph, if any.

# d)  Write out a copy of the tidy dataset to the `data` sub-directory as 
# an RDS file named `users_tidy.rds`. 

# e) What is one benefit of saving a dataset as an `rds` compared to a `csv`?

# read in using readr
top_user_2020 <- read_csv("data/users_top7_2020.csv")

#check to make sure it read in as a tibble
is_tibble(top_user_2020)

# tidy the data
users_tidy_1 <- top_user_2020 |> 
  #pivot everything but the user id column
  pivot_longer(cols = !user_id,
               #need to split each column into two, the value (match, passes or
               # likes) and the month)
               names_to = c(".value", "month"),
               #separator in the column head is an underscore
               names_sep = "_",
               #value from the existing cell goes into a new column "count"
               values_to = "count")

# still not tidy enough to fit onto one plot
users_tidy_1 |> 
  ggplot(aes(x = month, y = matches, group = user_id)) +
  geom_line(alpha = 0.25) +
  scale_y_reverse()

#take 2 at tidying
#something still wonky, I think with month as character
users_tidy_2 <- top_user_2020 |> 
  pivot_longer(cols = !user_id,
               names_to = c("category", "month"),
               names_sep = "_",
               values_to = "count") 

users_tidy_2 |> 
  ggplot(aes(x = month, y = count, color = category)) +
  geom_line() +
  facet_wrap(~user_id)

#take 3 tidying and visualizing
#parse number leaves the number in matches
top_user_2020 |> 
  pivot_longer(cols = !user_id,
               names_to = "category",
               values_to = "count") |> 
  mutate(month = parse_number(category))

users_tidy <- top_user_2020 |> 
  pivot_longer(cols = !user_id,
               names_to = c("category", "month"),
               names_sep = "_",
               values_to = "count")  |> 
  mutate(month = as.numeric(month))

write_rds(users_tidy, file = "data/users_tidy.rds")

users_tidy |> 
  ggplot(aes(x = month, y = count, color = category)) +
  geom_line() +
  facet_wrap(~user_id, scales = "free_y") +
  scale_x_continuous(name ="Month in 2020", 
                  breaks=c(2, 4, 6, 8, 10, 12)) +
  labs(y = "Count",
       title = "Top 7 user behavior by month in 2020")
