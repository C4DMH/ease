library(robustHD)

# make a lil distribution w/ outliers
original <- c(rnorm(100), rnorm(10, sd=50))

# winsorize
cleaned <- winsorize(original)

# wrap it up in a df
df <- data.frame(type=c(rep.int("original", length(na.omit(easeimm$siga))),
                        rep.int("cleaned",  length(easeimm_siga_cleaned))),
                 data=c(na.omit(easeimm$siga), easeimm_siga_cleaned))

# check if out if ya want (robustHD loads ggplot2) (Maybe change to boxplot because y-axis is random)
ggplot(df, aes(x=data, y=as.numeric(type), color=type))+
  geom_point(position=position_jitter(height=0.5))

# identify the points that were changed to the min and max
# (aka those points that are equal to the min and max but weren't before)
min_pts <- which(cleaned == min(cleaned) & original != min(cleaned))
max_pts <- which(cleaned == max(cleaned) & original != max(cleaned))

# then rank them
# rank will give you smallest -> largest ranks, 
# so to get least-> most outlierish we just reverse min_ranks
min_ranks <- rank(original[min_pts])
min_ranks <- max(min_ranks) - min_ranks + 1
max_ranks <- rank(original[max_pts])

# now you can replace them with whatever you want
scale_factor <- 0.1
rank_preserving <- cleaned
rank_preserving[min_pts] <- rank_preserving[min_pts]-(scale_factor * min_ranks)
rank_preserving[max_pts] <- rank_preserving[max_pts]+(scale_factor * max_ranks)

# check out what we did
outliers <- c(min_pts, max_pts)
comparison <- cbind(original[outliers],
                    cleaned[outliers],
                    rank_preserving[outliers])
# reorder by the first column
comparison <- comparison[order(comparison[,1]),]

# which looks like:
[,1]      [,2]      [,3]
[1,] -44.327307 -2.668972 -3.068972
[2,] -41.563231 -2.668972 -2.968972
[3,] -24.783572 -2.668972 -2.868972
[4,]  -4.367230 -2.668972 -2.768972
[5,]   3.601907  2.537502  2.637502
[6,]  32.932075  2.537502  2.737502
[7,]  64.109493  2.537502  2.837502
[8,]