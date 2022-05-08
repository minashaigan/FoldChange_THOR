#' A function for THOR normalizing chip-seq profile
#' @description 
#' input:
#' TMM_THOR_file_path
#' samples_peaks_profile
#' output:
#' samples_peaks_profile_normal
#' @export

THOR_normalization <- function(THOR_file_path, samples_peaks_profile){
  THOR_normalization_factors <- read.delim(THOR_file_path)
  THOR_normalization_factors <- as.numeric(strsplit(THOR_normalization_factors[3,1], "\\s+")[[1]])
  samples_peaks_profile_normal <-  samples_peaks_profile * THOR_normalization_factors
  lib_sizes = colSums(samples_peaks_profile)
  samples_peaks_profile_normal <- t(t(samples_peaks_profile)/(THOR_normalization_factors*lib_sizes))
  samples_peaks_profile_normal <- samples_peaks_profile_normal
  return(samples_peaks_profile_normal)
}
