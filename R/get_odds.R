#' Request Odds from the OddsJam API
#'
#' This is the workhorse function that executes the API requests from OddsJam.com/api
#'
#' To use this function you will need an API key and you must pass your API key to the 'set_OddsJam_api_key()' function.
#'
#' Type ?set_OddsJam_api_key into the console for more info.
#'
#' 'key' is the only parameter that is required. Just passing get_odds() will pull the first 500 available odds for all sports from all books.
#'
#' @param key Your api key is automatically put here if you have passed it to the set_OddsJam_api_key function.
#' @param page The page of the response you want. Note: the API is paginated and only sends 500 odds at a time.
#' @param sportsbook The sportsbook(s) you want to receive odds for. Leave this blank to get odds from all available sportsbooks. For a list of available sportsbooks visit https://developer.oddsjam.com/getting-started/
#' @param marketName The market you want to receive odds for (e.g. Moneyline).
#' @param sport The sport you want to receive odds for. Supported sports are: football, basketball, baseball, mma, boxing, hockey, soccer, tennis, golf, motorsports, esports.
#' @param league The league you want to receive odds for (e.g. England - Premier League).
#' @param gameId The OddsJam game ID you want to receive odds for (e.g. 37621).
#' @param time_zone You can get the times in your desired time zone. Defaults to Eastern Time. To see a list of useable time zones type OlsonNames() into the console.
#' @param on_date Specify which date you want odds for. Format as YYYY-MM-DD.
#'
#' @return Returns a dataframe with the requested odds.
#'
#' @examples
#' get_odds()

get_odds <- function(oj_url = "https://api-external.oddsjam.com/api/feed/",
                     key = .OddsJamEnv$data$apikey,
                     page = character(0),
                     sportsbook = character(0),
                     marketName = character(0),
                     sport = character(0),
                     league = character(0),
                     gameId = character(0),
                     time_zone = "America/New_York",
                     startDateBefore = character(0),
                     startDateAfter = character(0)
){
  # Do the API call
  response <- httr::GET(
    url = oj_url,
    query = list(
      key = key,
      page = page,
      sportsbook = sportsbook,
      marketName = marketName,
      sport = sport,
      league = league,
      gameId = gameId,
      startDateBefore = startDateBefore,
      startDateAfter = startDateAfter
    ),
    httr::add_headers(`Authorization` = sprintf("key %s", key))
  )

  # If the code isn't 200 print an error message and the response code
  if(response$status_code != 200){
    httr::stop_for_status(response)
    message("Type ?get_odds in the console for troubleshooting steps.")
  }

  # If the response is 200 then parse the results into a dataframe
  if(response$status_code == 200){
    # Parse the raw JSON data. Result: list of lists
    fin <- jsonlite::fromJSON(httr::content(response, as = "text", encoding = "UTF-8"),
                              httr::content(response, as="text", encoding="UTF-8"),
                              flatten = TRUE)

    # Make the list of lists into a manageable dataframe with correct names
    flat <- as.data.frame(t((matrix(unlist(fin), nrow=length(unlist(fin[1]))))))
    names(flat) <- names(unlist(fin[[1]]))

    # Force time zone
    flat$game.start_date <- suppressMessages(
      lubridate::as_datetime(flat$game.start_date, tz = time_zone)
    )

    flat$checked_date <- suppressMessages(
      lubridate::as_datetime(flat$checked_date, tz = time_zone)
    )

    flat$changed_date <- suppressMessages(
      lubridate::as_datetime(flat$changed_date, tz = time_zone)
    )

    result <- flat
  }
  return(result)
}
