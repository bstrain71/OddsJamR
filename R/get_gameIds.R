#' List gameIds
#'
#' To use this function you will need an API key and you must pass your API key to the 'set_OddsJam_api_key()' function.
#'
#' Type ?set_OddsJam_api_key into the console for more info.
#'
#' 'key' is the only parameter that is required.
#'
#' @param key Your api key is automatically put here if you have passed it to the set_OddsJam_api_key function.
#' @param page The page of the response you want. Note: the API is paginated and only sends 500 odds at a time.
#' @param sport The sport you want. Defaults to baseball. For a list of available sports see: https://developer.oddsjam.com/leagues
#' @param league Filter by league. You can get a list of available leagues with the get_leagues() function.
#' @param isLive Filters odds for live games. Defaults to FALSE. Using TRUE will override startDateBefore and startDateAfter.
#' @param startDateBefore Filter by games that start before a date. Format dates as "YYYY-MM-DD" for example "2021-10-31".
#' @param startDateAfter Filter by games that start after a date. Format dates as "YYYY-MM-DD" for example "2021-10-31"
#'
#' @return Returns a dataframe with the requested markets.
#'
#' @examples
#' get_gameIds()

get_gameIds <- function(oj_url = .OddsJamEnv$data$games_url,
                        key = .OddsJamEnv$data$apikey,
                        page = character(0),
                        sport = character(0),
                        league = character(0),
                        isLive = FALSE,
                        startDateBefore = character(0),
                        startDateAfter = character(0)
){
  # Do the API call
  response <- httr::GET(
    url = oj_url,
    query = list(
      key = key,
      page = page,
      sport = sport,
      league = league,
      isLive = ifelse(isLive == TRUE, 1, 0), # API takes 1 or 0 not TRUE/FALSE
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
    result <- jsonlite:::simplify(fin, flatten = TRUE)[["data"]]

  }
  return(result)
}
