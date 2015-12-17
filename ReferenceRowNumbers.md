http://stackoverflow.com/questions/17732728/referencing-row-number-in-r


* example: datsetname$rownumber = 1:nrow(datasetname)
*example of creating row index based on values in columns (example uses values in columns 7 and 10: filenam$subjIndex <- cumsum(!duplicated(filename[, c(7,10)]) )
* counter of number of repeat rows in row index (colA and colB are the columns used to create the row index:
filenam$subIndexLength <- ave( 1:nrow(filenam), filenam$colA, factor( filename$colB), FUN=function(x) 1:length(x) )
