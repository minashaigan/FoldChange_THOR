#' calculate fold change
#'
#' A function for calculating fold change of differential peaks
#'
#' @param count_matrix matrix of counts, peaks x samples
#' @param grp1 list of indices of first group
#' @param grp2 list of indices of second group
#' @return A list of fold changes 
#' @example examples/example.R
#' @export

#### read counts data with their peaks regions information ---------------------
calculate_fold_change <- function(count_matrix, grp1, grp2) {
  ## transform our data into log2 base
  count_matrix <- log2(count_matrix)
  
  ## calculate the mean of each peak per first group
  first_group = apply(count_matrix[, grp1], 1, mean)
  
  ## calculate the mean of each peak per second group
  second_group = apply(count_matrix[, grp2], 1, mean) 
  
  foldchanges <- first_group - second_group 
  return(foldchanges)
}