#' Returns a Text-Formatted List of a Day's Best Lines
#'
#' To use this function you will need an API key and you must pass your API key to the 'set_OddsJam_api_key()' function.
#'
#' Type ?set_OddsJam_api_key into the console for more info.
#'
#' 'key' is the only parameter that is required.
#'
#' @param startDateAfter Filter by games that start after a date. Format dates as "YYYY-MM-DD" for example "2021-10-31"
#' @param game_date The date you want to filter games by - format as "YYYY-MM-DD"
#' @param sport The sport you want lines for.
#' @param market The market you want lines for. Defaults to Moneyline. See ?get_markets for instructions on how to get a list of markets.
#'
#' @return Returns a dataframe with the requested markets.
#'

get_days_best <- function(game_date = character(0),
                          sport = character(0),
                          market = "Moneyline",
                          league = character(0)
){
  # Get game ids
  ids <- get_gameIds(sport = sport,
                     startDateAfter = game_date) # Gets game on that date forward

  # Filter games that are later than the selected date
  ids <- subset(ids, start_date <= paste0(game_date, 'T23:59'))

  if(length(ids$id) > 0){
    for(i in 1:length(ids$id)){
      #print(i)
      # Get the lines for that game
      temp <- tryCatch({
        # Try to get some odds for the id.
        get_odds(gameId = ids$id[i],
                 marketName = market,
                 league = league)
      },
      error = function(cond){
        #print(ids$id[i])
        #message(cond)
        NA
      })

      if( !is.null(names(temp)) ){

        # Split the dataframe into home and away
        home <- subset(temp, name == temp$game.home_team[1])
        away <- subset(temp, name == temp$game.away_team[1])

        # Get the best line for the home and away teams. find_best_line() is in utils.R
        home <- subset(home, price == find_best_line(home$price))
        away <- subset(away, price == find_best_line(away$price))


        if(exists('result') == FALSE){
          result <- rbind(away, home)
        } else {
          result <- rbind(result, away, home)
        }
      }
    }
  } else {
    message("No games on the selected date.")
  }
  if(exists('result')){
    return(result)
  }

}
