## Overview

The goal of this lab is to briefly cover a variety of topics to allow you to import and work with messy data. 

- Utilize the `readr` package, a member of the `tidyverse`, to load flat files (e.g., `csv` & `txt`) and to gain a better understanding of the basic data structure called a "tibble". Tibbles are data frames, but they tweak some of R's older behaviors to make life a little easier by avoiding unintentional mistakes/errors. The `tibble` package, another member of the `tidyverse`, provides the framework for these opinionated data frames which make working with data in the tidyverse possible.

- Understand the concepts of **relational data**. It is extremely rare that data analyses involve one all-encompassing dataset; we usually want to combine information from multiple data tables/sources to answer interesting questions. The collection of data tables/sources is called **relational data** because it is the relations connecting the datasets together that are important.

- Learn what it means to be a "tidy" dataset and how to tidy messy datasets utilizing the `tidyr` package -- a core member of the `tidyverse`. 

Useful resources:

- [`tibble` package home page](http://tibble.tidyverse.org/index.html).
- [`readr` package home page](http://readr.tidyverse.org/articles/readr.html)
- See [two-table verbs in `dplyr`](https://dplyr.tidyverse.org/articles/two-table.html) for more information concerning relational data. 
- [Relational Database Wikipedia Page](https://en.wikipedia.org/wiki/Relational_database)
- [`tidyr` package home page](http://tidyr.tidyverse.org/)
- [pivoting vignette](https://tidyr.tidyverse.org/articles/pivot.html)

**Additionally, you will learn how to ignore files that are too large for version control!**

## Instructions

After creating your own github repository and connecting it to your RStudio, you should work through the exercises provided in `L03_import_join_tidy.html`. A template is also provided (rename as lastname_firstname_L03.qmd).

You will only need to submit the rendered html file which **must contain a link to your github repo**. Including the github repo link provides all the support materials needed to reproduce your work, an essential feature of quality scientific work, especially data science/analysis work. See canvas for submission details.