# Fold Change Differential Peaks

## 1) Create count matrix
### 1a.) create .saf file
For using featureCounts package, we should first create a .saf file, containing list of regions of peaks based on THOR-exp-<date>-diffpeaks.narrowPeak file.
run the following command on the terminal:

```{bash}
echo -e "GeneID\tChr\tStart\tEnd\tStrand" > test.saf
awk -v FS='\t' -v OFS='\t' 'FNR > 1 { print $4, $1, $2, $3, $6 }' ~/FoldChange_THOR/data/TMM_THOR-diffpeaks.narrowPeak >> ~/FoldChange_THOR/data/TMM_THOR-diffpeaks.saf
```

### 1b.) Execute featureCounts
Based of data type which can be 'Single-End' or 'Paired-End', file path of .saf file, and path of .bam files:

```{r}
data_type = 'Single-End'
bam_files_file_path = '~/FoldChange_THOR/data/bwa/mergedLibrary'
saf_file_path = '~/FoldChange_THOR/data/TMM_THOR-diffpeaks.saf'
count_matrix = create_count_matrix(data_type, bam_files_file_path, saf_file_path)
pander::pander(head(count_matrix, c(6, 6)))
```
|  Old_H3K9ac_R1.mLb.clN.sorted.bam | Old_H3K9ac_R10.mLb.clN.sorted.bam |Old_H3K9ac_R2.mLb.clN.sorted.bam | Old_H3K9ac_R3.mLb.clN.sorted.bam |Old_H3K9ac_R4.mLb.clN.sorted.bam| Old_H3K9ac_R5.mLb.clN.sorted.bam|
| --- | --- |
| 128 | 97 |134|39|142|142|
| 45 | 19 |34|22|64|64|
| 33 | 13 |24|14|35|35|
| 156| 105|144|74|137|137|
| 33| 14|17|7|26|26|
| 171| 101|162|68|246|246|
  
```{r}
colnames(count_matrix)
```
  
[1]  0.4339349  0.4972222  0.8037886  0.4511144 -0.2598497  0.4383431

## 2) Calculate fold changes
Based on indices of two biological groups:

```{r}
grp1 = c(1:10)
grp2 = c(11:19)
fold_changes = calculate_fold_change(count_matrix, grp1, grp2)
head(fold_changes)
```

## 3) plot fold changes in p-values

You can also plot fold changes in p-values:

```{r}
raw_pvalues = calculate_pvalues(count_matrix, grp1, grp2)
plot_foldChange_pValues(count_matrix, fold_changes, raw_pvalues, pvalue_thr = 0.05, lfc_thr = 0.58)
```

![alt foldChange_pValues](https://github.com/minashaigan/FoldChange_THOR/blob/main/Figures/foldChange_pValues.png)
  
## 4) plot fold changes in normalized counts

You can also plot fold changes in normalized counts:

```{r}
plot_foldChange_counts(fold_changes, count_matrix, lfc_thr = 0.58)
```

![alt foldChange_pValues](https://github.com/minashaigan/FoldChange_THOR/blob/main/Figures/FoldChange_counts.png)

  ### References
  1. Count reads in consensus peaks ([`featureCounts`](http://bioinf.wehi.edu.au/featureCounts/))
  2. Fold Change Visualization ([`hbctraining`](https://hbctraining.github.io/Intro-to-R-with-DGE/lessons/B1_DGE_visualizing_results.html))
  3. Differential expression data analysis ([`data_analysis`](https://www.bioconductor.org/help/course-materials/2015/Uruguay2015/day5-data_analysis.html))
