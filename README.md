### Collection of code and references for doing basic data manipulation in R.

##### Reading in pound sign:
* [Stackoverflow question here.](http://stackoverflow.com/questions/7086945/how-can-read-numeral-signs-as-part-of-a-column-header). Pound sign is comment character in R, but also may be included in input file (eg Apt #3).

##### Creating reference row numbers: 
* [Stackoverflow reference.](http://stackoverflow.com/questions/17732728/referencing-row-number-in-r)
* example: datsetname$rownumber = 1:nrow(datasetname)
* example of creating row index based on values in columns (example uses values in columns 7 and 10: filenam$subjIndex <- cumsum(!duplicated(filename[, c(7,10)]) )
* counter of number of repeat rows in row index (colA and colB are the columns used to create the row index: filenam$subIndexLength <- ave( 1:nrow(filenam), filenam$colA, factor( filename$colB), FUN=function(x) 1:length(x) )

##### summing large matrices: 
* [Stackoverflow reference.](http://stackoverflow.com/questions/21921422/row-sum-for-large-term-document-matrix-simple-triplet-matrix-tm-package)
* Uses [R SLAM package](https://cran.r-project.org/web/packages/slam/index.html)

##### RODBC_example.R:  sample code for using RODBC package to download data from database.
