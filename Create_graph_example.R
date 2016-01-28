require(dplyr)
require(ggplot2)
library(gridExtra)

setwd("/Users/")
load("SLM.Rda")

SLM<- SLM %>%
  arrange(POOL_NAME,MONTHS_SINCE_ISSUE) %>%
  group_by(POOL_NAME) %>%
  mutate( lNUM_LOANS = lag(NUM_LOANS),
          lDEFER_NUM = lag(DEFER_NUM),
          lFORB_NUM = lag(FORB_NUM),
          lREPAY_NUM = lag(REPAY_NUM),
          lCURRENT_NUM = lag(CURRENT_NUM),
          lDELINQ_31_60_NUM = lag(DELINQ_31_60_NUM),
          lDEINQ_61_90_NUM = lag(DEINQ_61_90_NUM),
          lDELINQ_91_120_NUM = lag(DELINQ_91_120_NUM),
          lDELINQ_120PLUS_NUM = lag(DELINQ_120PLUS_NUM)
          )

SLM <- mutate(SLM, dNUM_LOANS= lNUM_LOANS - NUM_LOANS,
              dDEFER_NUM = lDEFER_NUM-DEFER_NUM,
              dFORB_NUM = lFORB_NUM -FORB_NUM ,
              dREPAY_NUM = lREPAY_NUM -REPAY_NUM,
              dCURRENT_NUM = lCURRENT_NUM - CURRENT_NUM,
              dDELINQ_31_60_NUM = lDELINQ_31_60_NUM - DELINQ_31_60_NUM,
              dDEINQ_61_90_NUM = lDEINQ_61_90_NUM - DEINQ_61_90_NUM,
              dDELINQ_91_120_NUM = lDELINQ_91_120_NUM - DELINQ_91_120_NUM,
              dDELINQ_120PLUS_NUM = lDELINQ_120PLUS_NUM - DELINQ_120PLUS_NUM
              )

#count(SLM, VINTAGE)

SLM$missIDRNum <-with(SLM, ifelse(is.na(SLM$IDR_NUM),1,0))
count(SLM, missIDRNum)

obscount <- SLM %>% group_by(POOL_NAME) %>% summarise(num_obs_by_pool=n())
avector <-obscount[['POOL_NAME']]
class(avector)
avector <-as.vector(avector)
avector[89]

pdf("SLM.pdf")
for (i in 1:95){
  onepool <-filter(SLM, grepl(avector[i],POOL_NAME))
  p1<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=NUM_LOANS)) + geom_line(col="blue")    
  p2<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=DEFER_NUM)) + geom_line(col="blue")    
  p3<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=FORB_NUM)) + geom_line(col="blue")    
  p4<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=REPAY_NUM)) + geom_line(col="blue")    
  p5<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=CURRENT_NUM)) + geom_line(col="blue") 
  p6<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=DELINQ_31_60_NUM)) + geom_line(col="blue")    
  p7<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=DEINQ_61_90_NUM)) + geom_line(col="blue")    
  p8<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=DELINQ_91_120_NUM)) + geom_line(col="blue")    
  p9<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=DELINQ_120PLUS_NUM)) + geom_line(col="blue")    
  grid.arrange(p1, p2,p3,p4,p5, p6,p7,p8,p9, ncol=3, nrow=3, top = avector[i])
  }
dev.off()

pdf("SLMdif.pdf")
for (i in 1:95){
  onepool <-filter(SLM, grepl(avector[i],POOL_NAME))
  p1<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dNUM_LOANS)) + geom_line(col="blue")    
  p2<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dDEFER_NUM)) + geom_line(col="blue")    
  p3<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dFORB_NUM)) + geom_line(col="blue")    
  p4<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dREPAY_NUM)) + geom_line(col="blue")    
  p5<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dCURRENT_NUM)) + geom_line(col="blue") 
  p6<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dDELINQ_31_60_NUM)) + geom_line(col="blue")    
  p7<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dDEINQ_61_90_NUM)) + geom_line(col="blue")    
  p8<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dDELINQ_91_120_NUM)) + geom_line(col="blue")    
  p9<- ggplot(onepool, aes(x=MONTHS_SINCE_ISSUE, y=dDELINQ_120PLUS_NUM)) + geom_line(col="blue")    
  grid.arrange(p1, p2,p3,p4,p5, p6,p7,p8,p9, ncol=3, nrow=3, top = avector[i])
}
dev.off()


