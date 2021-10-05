find_best_line <- function(x){
  if(any(x > 0)){
    x <- x[x > 0]
    x <- max(x)
    return(x)
  } else {
    x <- min(x)
    return(x)
  }
}
