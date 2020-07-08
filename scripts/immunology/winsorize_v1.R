library(car)

#visualize outliers

boxplot(df$v1)

#create variable 'high' for high outliers (mean + 3SD) of variable 1 (v1) in dataframe (df)

high <- mean(df$v1, na.rm = TRUE) + sd(df$v1, na.rm = TRUE)*3 

#identify # of cells > high in the v1 column

sum(df$v1 > high, na.rm=TRUE)

#identify which cells > high in the v1 column 

which(df$v1 > high)

#note cell values, order manually (for example, here, outliers are valued at 15000, and 21000)

#in v1 column, replace cell with value 15000 with high

df$v1 <-recode(df$v1 ,"15000=high")

#in v1 column, replace cell with value 21000 with (high +.01) 

df$v1 <-recode(df$v1 ,"21000=(high+.01)")

#create variable 'low' for low outliers (mean - 3SD) of variable 1 (v1) in dataframe (df)

low <- mean(df$v1, na.rm = TRUE) - sd(df$v1, na.rm = TRUE)*3 

#identify # of cells <  low in the v1 column

sum(df$v1 < low , na.rm=TRUE)

#identify which cells < low  in the v1 column 

which(df$v1 < low )

#note cell values, order manually (for example, here, outliers are valued at 8, and 15)

#in v1 column, replace cell with value 8 with low

df$v1 <-recode(df$v1 ,"8=low")

#in v1 column, replace cell with value 15 with (low - .01) 

df$v1 <-recode(df$v1 ,"15=(low-.01)")