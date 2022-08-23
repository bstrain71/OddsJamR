.onLoad <- function(libname, pkgname){
  .OddsJamEnv <<- new.env()

  .OddsJamEnv$data <- list(
    key <- NULL
    )
  .OddsJamEnv$data$games_url <- "https://api-external.oddsjam.com/api/v2/games"
  .OddsJamEnv$data$odds_url <- "https://api-external.oddsjam.com/api/v2/game-odds"
  .OddsJamEnv$data$leagues_url <- "https://api-external.oddsjam.com/api/v2/leagues/"

}
