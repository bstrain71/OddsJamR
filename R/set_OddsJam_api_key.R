#' Pass your secret API key to this function
#'
#' @param key Your secret API key. Do not share this with anyone.
#' @examples
#' set_OddsJam_api_key("1a1a1a11-2222-33b3-ccc4-55d5dd5555d5")
#'

set_OddsJam_api_key <- function(key){
  if(nchar(key) == 36){
    .OddsJamEnv$data$apikey <- key
  }
  else{
    warning("You you need a valid API key to access the OddsJam API. Valid keys are 36 characters long and look like this: 1a1a1a11-2222-33b3-ccc4-55d5dd5555d5")
  }
}
