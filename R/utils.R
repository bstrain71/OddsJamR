find_best_line <- function(x){
  x <- as.numeric(x)
  if(any(x > 0)){
    x <- x[x > 0]
    x <- max(x)
    return(x)
  } else {
    x <- max(x)
    return(x)
  }
}
