```{r}

siga_up_limit <- (siga_summary$mean + 3*(siga_summary$sd))
siga_up_limit
siga_lo_limit <- (siga_summary$mean - 3*(siga_summary$sd))

il1b_up_limit <- (il1b_summary$mean + 3*(il1b_summary$sd))
il1b_up_limit
il1b_lo_limit <- (il1b_summary$mean - 3*(il1b_summary$sd))

crp_up_limit <- (crp_summary$mean + 3*(crp_summary$sd))
crp_up_limit
crp_lo_limit <- (crp_summary$mean - 3*(crp_summary$sd))

# But for the low limit we have to make sure it isn't impossible, i.e., negative
siga_lo_limit <- ifelse(siga_lo_limit<0, 0, siga_lo_limit)
siga_lo_limit

il1b_lo_limit <- ifelse(il1b_lo_limit<0, 0, il1b_lo_limit)
il1b_lo_limit

crp_lo_limit <- ifelse(crp_lo_limit<0, 0, crp_lo_limit)
crp_lo_limit

# in order to use the Winsorize FUN with set min/max vals, Winsorize must be capitalized :)
# original: easeimm$siga_frc
# cleaned:
easeimm$siga_w <- Winsorize(easeimm$siga_frc, minval = siga_lo_limit, maxval = siga_up_limit, na.rm = TRUE)

easeimm$il1b_w <- Winsorize(easeimm$il1b, minval = il1b_lo_limit, maxval = il1b_up_limit, na.rm = TRUE)

easeimm$crp_w <- Winsorize(easeimm$crp, minval = crp_lo_limit, maxval = crp_up_limit, na.rm = TRUE)

# Code from here to end of chunk thank you to Johnny
# Put both the original data and the cleaned data in the same df:
df_siga <- data.frame(type=c(rep.int("easeimm$siga_frc", length(easeimm$siga_frc)),
                             rep.int("easeimm$siga_w",  length(easeimm$siga_w))),
                      data=c(easeimm$siga_frc, easeimm$siga_w))

df_il1b <- data.frame(type=c(rep.int("easeimm$il1b", length(easeimm$il1b)),
                             rep.int("easeimm$il1b_w",  length(easeimm$il1b_w))),
                      data=c(easeimm$il1b, easeimm$il1b_w))

df_crp <- data.frame(type=c(rep.int("easeimm$crp", length(easeimm$crp)),
                            rep.int("easeimm$crp_w",  length(easeimm$crp_w))),
                     data=c(easeimm$crp, easeimm$crp_w))

# This is to check it out but I'd probably change it to two boxplots:
ggplot(df_siga, aes(x=data, y=as.numeric(type), color=type))+
  geom_point(position=position_jitter(height=0.5))

ggplot(df_il1b, aes(x=data, y=as.numeric(type), color=type))+
  geom_point(position=position_jitter(height=0.5))

ggplot(df_crp, aes(x=data, y=as.numeric(type), color=type))+
  geom_point(position=position_jitter(height=0.5))

# identify the points that were changed to the min and max
# (aka those points that are equal to the min and max but weren't before)

cleaned_siga <- na.omit(easeimm$siga_w)
original_siga <- na.omit(easeimm$siga_frc)

min_pts_siga <- which(cleaned_siga == min(cleaned_siga) & original_siga != min(cleaned_siga))
max_pts_siga <- which(cleaned_siga == max(cleaned_siga) & original_siga != max(cleaned_siga))

cleaned_il1b <- na.omit(easeimm$il1b_w)
original_il1b <- na.omit(easeimm$il1b)

min_pts_il1b <- which(cleaned_il1b == min(cleaned_il1b) & original_il1b != min(cleaned_il1b))
max_pts_il1b <- which(cleaned_il1b == max(cleaned_il1b) & original_il1b != max(cleaned_il1b))

cleaned_crp <- na.omit(easeimm$crp_w)
original_crp <- na.omit(easeimm$crp)

min_pts_crp <- which(cleaned_crp == min(cleaned_crp) & original_crp != min(cleaned_crp))
max_pts_crp <- which(cleaned_crp == max(cleaned_crp) & original_crp != max(cleaned_crp))

# NOTE: I haven't tested anything below because I don't have a variable with more than one outlier...

# then rank them
# rank will give you smallest -> largest ranks, 
# so to get least-> most outlierish we just reverse min_ranks
min_ranks_siga <- rank(original_siga[min_pts_siga])
min_ranks_siga <- max(min_ranks_siga) - min_ranks_siga + 1
max_ranks_siga <- rank(original_siga[max_pts_siga])

min_ranks_il1b <- rank(original_il1b[min_pts_il1b])
min_ranks_il1b <- max(min_ranks_il1b) - min_ranks_il1b + 1
max_ranks_il1b <- rank(original_il1b[max_pts_il1b])

min_ranks_crp <- rank(original_crp[min_pts_crp])
min_ranks_crp <- max(min_ranks_crp) - min_ranks_crp + 1
max_ranks_crp <- rank(original_crp[max_pts_crp])

# now you can replace them with whatever you want

rank_preserving_siga <- cleaned_siga
rank_preserving_siga[min_pts_siga] <- rank_preserving_siga[min_pts_siga]-(increment * min_ranks_siga)
rank_preserving_siga[max_pts_siga] <- rank_preserving_siga[max_pts_siga]+(increment * max_ranks_siga)

rank_preserving_il1b <- cleaned_il1b
rank_preserving_il1b[min_pts_il1b] <- rank_preserving_il1b[min_pts_il1b]-(increment * min_ranks_il1b)
rank_preserving_il1b[max_pts_il1b] <- rank_preserving_il1b[max_pts_il1b]+(increment * max_ranks_il1b)

rank_preserving_crp <- cleaned_crp
rank_preserving_crp[min_pts_crp] <- rank_preserving_crp[min_pts_crp]-(increment * min_ranks_crp)
rank_preserving_crp[max_pts_crp] <- rank_preserving_crp[max_pts_crp]+(increment * max_ranks_crp)

# check out what we did
outliers_siga <- c(min_pts_siga, max_pts_siga)
comparison_siga <- cbind(original_siga[outliers_siga],
                         cleaned_siga[outliers_siga],
                         rank_preserving_siga[outliers_siga])

outliers_il1b <- c(min_pts_il1b, max_pts_il1b)
comparison_il1b <- cbind(original_il1b[outliers_il1b],
                         cleaned_il1b[outliers_il1b],
                         rank_preserving_il1b[outliers_il1b])

outliers_crp <- c(min_pts_crp, max_pts_crp)
comparison_crp <- cbind(original_crp[outliers_crp],
                        cleaned_crp[outliers_crp],
                        rank_preserving_crp[outliers_crp])

# reorder by the first column
comparison_siga <- comparison_siga[order(comparison_siga[,1]),]

comparison_il1b <- comparison_il1b[order(comparison_il1b[,1]),]

comparison_crp <- comparison_crp[order(comparison_crp[,1]),]

```