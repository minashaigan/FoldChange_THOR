#' plot fold Change p-Values
#'
#' @param count_matrix  matrix of counts, peaks x samples
#' @param foldchange list of log 2 fold changes
#' @param rawpvalue list of p values
#' @param pvalue_thr float number as threshold for p-values
#' @param lfc_thr float number as threshold for log 2 fold changes
#' @return A pdf of plot
#' @example examples/example.R
#' @export

#### read counts data with their peaks regions information ---------------------
plot_foldChange_pValues <- function(count_matrix, foldchange, rawpvalue, pvalue_thr = 0.05, lfc_thr = 0.58) {
  ### Set thresholds
  padj.cutoff <- pvalue_thr
  lfc.cutoff <- lfc_thr
  
  threshold <- rawpvalue < padj.cutoff & abs(foldchange) > lfc.cutoff
  
  # Open a pdf file
  pdf("plot_foldChange_pValues.pdf")
  # Volcano plot
  ggplot2::ggplot(count_matrix) +
    ggplot2::geom_point(ggplot2::aes(x=foldchange, y=-1*log10(rawpvalue), colour=threshold)) +
    ggplot2::ggtitle("log2 Fold Change (First group vs Second group)") +
    ggplot2::xlab("log2 fold change") + 
    ggplot2::ylab("-log10 adjusted p-value") +
    ggplot2::theme(legend.position = "none",
          plot.title = ggplot2::element_text(size = ggplot2::rel(1.5), hjust = 0.5),
          axis.title = ggplot2::element_text(size = ggplot2::rel(1.25)))
  # Close the pdf file
  dev.off()
  print("saved as plot_foldChange_pValues.pdf")
}