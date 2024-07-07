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
