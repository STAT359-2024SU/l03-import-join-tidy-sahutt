# L03-import-join-tidy ----


## load packages ----

library(tidyverse)

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

