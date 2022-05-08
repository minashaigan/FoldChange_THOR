#' A function for counting features from a bed file of differential peaks
#' @description 
#' input:
#' saf_file_path
#' bam_files_file_path
#' output:
#' count matrix
#' @export

if (!require("Rsubread", quietly = TRUE)) {
  if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  BiocManager::install("Rsubread")
}

featureCounts_peaks <- function(data_type = c("Single-End", "Paired-End"), saf_file_path, bam_files_file_path){
  
  single_end <- if(data_type == 'Single-End') 1 else 0
  
  myfiles <- list.files(path = bam_files_file_path, pattern=paste0("*.bam$"), full.names = T)
  myfiles <- myfiles[ !grepl("INPUT", myfiles) ]
  myfiles <- myfiles[ !grepl("Input", myfiles) ]
  myfiles <- myfiles[ !grepl("input", myfiles) ]
  
  if(single_end){
    feature_counts = Rsubread::featureCounts(files = myfiles,
                                             annot.ext = saf_file_path,
                                             nthreads=16)
  }
  else{
    feature_counts = Rsubread::featureCounts(files = myfiles,
                                             annot.ext = saf_file_path,
                                             nthreads=16, isPairedEnd = TRUE, autosort = FALSE)
  }
  
  
  featurecounts_file_path <- paste0(gsub(".saf","", saf_file_path), "_feature_counts.txt")
  feature_counts_diff_peaks <- cbind(feature_counts$annotation, feature_counts$counts)
  
  write.table(feature_counts_diff_peaks, file = featurecounts_file_path, sep = "\t",
              row.names = FALSE, col.names = TRUE, quote = FALSE)
  
  print(featurecounts_file_path)
  return(featurecounts_file_path)
}