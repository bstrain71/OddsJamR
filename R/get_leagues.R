#' List Available Leagues for a Sport
#'
#' To use this function you will need an API key and you must pass your API key to the 'set_OddsJam_api_key()' function.
#'
#' Type ?set_OddsJam_api_key into the console for more info.
#'
#' 'key' is the only parameter that is required.
#'
#' @param key Your api key is automatically put here if you have passed it to the set_OddsJam_api_key function.
#' @param sport The sport you want. Defaults to baseball. For a list of available sports see: https://developer.oddsjam.com/leagues
#' @param isLive Filters odds for live games. Defaults to FALSE.
#'
#' @return Returns a dataframe with the requested leagues.
#'
#' @examples
#' get_leagues()

get_leagues <- function(oj_url = .OddsJamEnv$data$leagues_url,
                        key = .OddsJamEnv$data$apikey,
                        sport = character(0),
                        isLive = FALSE
){
  # Do the API call
  response <- httr::GET(
    url = oj_url,
    query = list(
      key = key,
      sport = sport,
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
    # flat <- as.data.frame(t((matrix(unlist(fin), nrow=length(unlist(fin[1]))))))
    # names(flat) <- names(unlist(fin[[1]]))

    # Make the list of lists into a manageable dataframe with correct names
    result <- jsonlite:::simplify(fin, flatten = TRUE)[["data"]]
  }
  return(result)
}
