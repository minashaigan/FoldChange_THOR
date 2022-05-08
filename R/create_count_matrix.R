#' create count matrix
#'
#' A function for creating matrix count data of peaks
#'
#' @param data_type whether sequneces are Single-End or Paired-End
#' @param bam_files_file_path A string file path of bam files
#' @param saf_file_path A string file path of saf files
#' @return matrix of count data 
#' @example examples/example.R
#' @export

source('FoldChange_THOR/R/featureCounts_peaks.R')

#### read counts data with their peaks regions information ---------------------
create_count_matrix <- function(data_type = c("Single-End", "Paired-End"), bam_files_file_path, saf_file_path) {
  ## create matrix of count data
  featurecounts_file_path <- featureCounts_peaks(data_type, saf_file_path, bam_files_file_path)
  samples_peaks_profile <- read.table(featurecounts_file_path , sep = "\t", header = T)
  samples_peaks_profile <- samples_peaks_profile[,-c(1:6)]
  
  return(samples_peaks_profile)
}