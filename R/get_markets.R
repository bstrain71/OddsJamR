#' List Available Markets
#'
#' To use this function you will need an API key and you must pass your API key to the 'set_OddsJam_api_key()' function.
#'
#' Type ?set_OddsJam_api_key into the console for more info.
#'
#' 'key' is the only parameter that is required.
#'
#' @param key Your api key is automatically put here if you have passed it to the set_OddsJam_api_key function.
#' @param page The page of the response you want. Note: the API is paginated and only sends 500 odds at a time.
#' @param gameId The OddsJam game ID you want to receive odds for (e.g. 37621).
#' @param isLive Filters odds for live games. Defaults to TRUE.
#' @param time_zone You can get the times in your desired time zone. Defaults to Eastern Time. To see a list of useable time zones type OlsonNames() into the console.
#'
#' @return Returns a dataframe with the requested markets.
#'
#' @examples
#' get_markets()

get_markets <- function(oj_url = "https://api-external.oddsjam.com/api/feed/markets/",
                     key = .OddsJamEnv$data$apikey,
                     page = character(0),
                     gameId = character(0),
                     isLive = TRUE,
                     time_zone = "America/New_York"
){
  # Do the API call
  response <- httr::GET(
    url = oj_url,
    query = list(
      key = key,
      page = page,
      gameId = gameId,
      isLive = ifelse(isLive == TRUE, 1, 0) # API takes 1 or 0 not TRUE/FALSE
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

    result <- flat
  }
  return(result)
}
