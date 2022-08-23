
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

You must load the library and authenticate with the API using your API
key.

``` r
library(OddsJamR)
set_OddsJam_api_key("your-key-here")
```

### Core Functions

Get some game ids for a range of dates. The “game\_id” parameter is now
required to get odds, so you should start with this function.

``` r
ids <- get_gameIds(sport = 'baseball',
                   league = 'MLB',
                   startDateAfter = '2022-08-21',
                   startDateBefore = '2022-08-24')
```

Get a list of leagues. If you leave the <sport> parameter blank you’ll
get all available leagues for all sports.

``` r
leagues <- get_leagues(sport = 'football')
```

Get some odds for a given date. Note that the <game_id> parameter is
required.

``` r
some_odds <- get_odds(game_id = ids$id[21])
```

Get the best lines for a given game\_id.

``` r
best <- get_days_best(game_date = '2022-08-23',
                      sport = 'baseball',
                      game_id = ids$id[21])
```

Note that historical odds are not available: you can’t get odds for past
dates.

Dates must be written in the format ‘YYYY-MM-DD’ like ‘2021-10-07’

Sports available are: -football -basketball -baseball -mma -boxing
-hockey -soccer -tennis -golf -motorsports -esports
