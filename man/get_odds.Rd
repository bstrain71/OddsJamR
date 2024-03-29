% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_odds.R
\name{get_odds}
\alias{get_odds}
\title{Request Odds from the OddsJam API}
\usage{
get_odds(
  oj_url = "https://api-external.oddsjam.com/api/feed/",
  key = .OddsJamEnv$data$apikey,
  page = character(0),
  sportsbook = character(0),
  marketName = character(0),
  sport = character(0),
  league = character(0),
  gameId = character(0),
  time_zone = "America/New_York"
)
}
\arguments{
\item{key}{Your api key is automatically put here if you have passed it to the set_OddsJam_api_key function.}

\item{page}{The page of the response you want. Note: the API is paginated and only sends 500 odds at a time.}

\item{sportsbook}{The sportsbook(s) you want to receive odds for. Leave this blank to get odds from all available sportsbooks. For a list of available sportsbooks visit https://developer.oddsjam.com/getting-started/}

\item{marketName}{The market you want to receive odds for (e.g. Moneyline).}

\item{sport}{The sport you want to receive odds for. Supported sports are: football, basketball, baseball, mma, boxing, hockey, soccer, tennis, golf, motorsports, esports.}

\item{league}{The league you want to receive odds for (e.g. England - Premier League).}

\item{gameId}{The OddsJam game ID you want to receive odds for (e.g. 37621).}

\item{time_zone}{You can get the times in your desired time zone. Defaults to Eastern Time. To see a list of useable time zones type OlsonNames() into the console.}

\item{on_date}{Specify which date you want odds for. Format as YYYY-MM-DD.}
}
\value{
Returns a dataframe with the requested odds.
}
\description{
This is the workhorse function that executes the API requests from OddsJam.com/api
}
\details{
To use this function you will need an API key and you must pass your API key to the 'set_OddsJam_api_key()' function.

Type ?set_OddsJam_api_key into the console for more info.

'key' is the only parameter that is required. Just passing get_odds() will pull the first 500 available odds for all sports from all books.
}
\examples{
get_odds()
}
