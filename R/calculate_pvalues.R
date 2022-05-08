#' calculate p-values
#'
#' A function for calculating p-values of differential peaks
#'
#' @param count_matrix matrix of counts, peaks x samples
#' @param grp1 list of indices of first group
#' @param grp2 list of indices of second group
#' @return A list of p-values
#' @example examples/example.R
#' @export

#### read counts data with their peaks regions information ---------------------
calculate_pvalues <- function(count_matrix, grp1, grp2) {
  ttestRat <- function(df, grp1, grp2) {
    x = df[grp1]
    y = df[grp2]
    x = as.numeric(x)
    y = as.numeric(y)  
    results = t.test(x, y)
    results$p.value
  }
  rawpvalue = apply(count_matrix, 1, ttestRat, grp1 = grp1, grp2 = grp2)
  
  return(rawpvalue)
}