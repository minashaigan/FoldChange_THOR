#' plot fold Change counts
#'
#' @param foldchange list of log 2 fold changes
#' @param count_matrix matrix of counts, peaks x samples
#' @param lfc_thr float number as threshold for log 2 fold changes
#' @return A pdf of plot
#' @example examples/example.R
#' @export

#### read counts data with their peaks regions information ---------------------
plot_foldChange_counts <- function(foldchange, count_matrix, lfc_thr = 0.58) {
  
  ### Set thresholds
  lfc.cutoff <- lfc_thr
  
  threshold <- abs(foldchange) > lfc.cutoff
  
  # Open a pdf file
  # pdf("plot_foldChange_counts.pdf") 
  # Volcano plot
  ggplot2::ggplot(count_matrix) +
    ggplot2::geom_point(ggplot2::aes(x=rowMeans(count_matrix), y=foldchange, colour=threshold)) +
    ggplot2::ggtitle("log2 Fold Change (First group vs Second group)") +
    ggplot2::xlab("mean of normalized counts") + 
    ggplot2::ylab("log2 fold change")
  # Close the pdf file
  # dev.off()
  # print("saved as plot_foldChange_counts.pdf") 
}