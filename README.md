
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

Get some odds for a given date.

``` r
some_odds <- get_odds(sport = 'football',
                      startDateAfter = '2021-10-07',
                      startDateBefore = '2021-10-08'
                      )
```

Get the best lines for a given sport on a given day. Market defaults to
Moneyline.

``` r
best <- get_days_best(game_date = '2021-10-07',
                      sport = 'football',
                      market = 'Moneyline')
```

For a list of available markets you will need a gameId - otherwise you
will get markets for all games for all sports.

``` r
# Get some game IDs
ids <- get_gameIds(sport = 'football',
                   league = 'NFL',
                   startDateAfter = '2021-10-07',
                   startDateBefore = '2021-10-08')

# Look at which games are in the selected date range
ids

# Get the available markets for the first game in the list
markets <- get_markets(gameId = ids$id[1])
```

Once you have a list of markets for a game, you can check the best
available lines for that market amongs all available sportsbooks.

``` r
best_market <- get_days_best(gameId = ids$id[1],
                             market = markets$name[29])
```

Note that historical odds are not available: you can’t get odds for past
dates.

Dates must be written in the format ‘YYYY-MM-DD’ like ‘2021-10-07’

Sports available are: -football -basketball -baseball -mma -boxing
-hockey -soccer -tennis -golf -motorsports -esports
