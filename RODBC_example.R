library(RODBC)

channel <- odbcConnect("ODBCNAME",uid="USERID", pwd="PASSWORD")

# Check that connection is working (Optional)
odbcGetInfo(channel)

# Find out what tables are available (Optional)
sqlTables(channel, schema="SCHEMA")

vars<- sqlQuery(channel, "
 SELECT top 5 * 
 FROM
 remit_data.fact_remit_data ")

save(vars, file="C:\\temp\\test.Rda")

close(channel)



