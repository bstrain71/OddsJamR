
<!-- README.md is generated from README.Rmd. Please edit that file -->

# OddsJamR

<!-- badges: start -->
<!-- badges: end -->

This package lets you interact with the OddsJam.com API. Documentation
for the API is available here:
<https://developer.oddsjam.com/getting-started/>

You will need an API key to use this package. You can get one by
emailing <api@oddsjam.com>

## Installation

You can install the development version of OddsJamR from github.

Use:

``` r
devtools::install_github("bstrain71/OddsJamR")
```

    ## Authentication

    You must load the library and authenticate with the API using your API key.



    ```r
    library(OddsJamR)
    set_OddsJam_api_key("your-key-here")
    #> Warning in set_OddsJam_api_key("your-key-here"): You you need a valid API key
    #> to access the OddsJam API. Valid keys are 36 characters long and look like this:
    #> 1a1a1a11-2222-33b3-ccc4-55d5dd5555d5

To get the best sportsbook lines for a given sport on a given day try
the code below.

Note that historical odds are not available: you can’t get odds for past
dates.

Dates must be written in the format ‘YYYY-MM-DD’ like ‘2021-10-07’

Sports available are: -football -basketball -baseball -mma -boxing
-hockey -soccer -tennis -golf -motorsports -esports

``` r
best <- get_days_best(game_date = '2021-10-07',
                      sport = 'football')
```

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
