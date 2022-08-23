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
#' @param game_id The game you want the selected market for. If you want all markets use the get_odds() function.
#' @param sport The sport you want lines for.
#' @param market The market you want lines for. Defaults to Moneyline. See ?get_markets for instructions on how to get a list of markets.
#'
#' @return Returns a dataframe with the requested markets.
#'

get_days_best <- function(game_date = character(0),
                          sport = character(0),
                          league = character(0),
                          game_id = character(0)
){

  # If no game_id is provided then get all games for the selected market.
  if(length(game_id) == 0){
    # Get game ids
    ids <- get_game_ids(sport = sport,
                       startDateAfter = game_date) # Gets game on that date forward

    # Filter games that are later than the selected date
    ids <- subset(ids, start_date <= paste0(game_date, 'T23:59'))

    if(length(ids$id) > 0){
      for(i in 1:length(ids$id)){
        #print(i)
        # Get the lines for that game
        temp <- tryCatch({
          # Try to get some odds for the id.
          get_odds(game_id = ids$id[i],
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
    }}

  # If a game_id is provided then get the lines for the selected market in the selected game.
  else {
    all_market_lines <- get_odds(game_id = game_id,
                                 marketName = market)

    all_market_lines <- all_market_lines$odds[[1]]

    unique_markets <- unique(all_market_lines$market_name)

    for(i in 1:length(unique_markets)){
      temp <- subset(all_market_lines, market_name == unique_markets[i])
      temp <- subset(temp, price == find_best_line(temp$price))
      if(exists('result') == FALSE){
        result <- temp
      } else {
        result <- rbind(result, temp)
      }
      if(exists('result') == FALSE){
        message("Nothing available for the selected market and game.")
      }
    }
  }


if(exists('result')){
  return(result)
}
}
