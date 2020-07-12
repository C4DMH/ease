library(readr)

##### Calculate intra-assay CVs (from 450 OD, not concentration) from the sample (duplicate) CVs. Also, the units are PERCENTAGES even though these are not indicated (so if the value is 5.39, that is 5.39%, or 0.0539, not 539%):
intraassays <- read_csv("EASE_immune_intraassays.csv")
View(intraassays)
crp_pl1_cv <- mean(intraassays$crp_pl1, na.rm = TRUE)
crp_pl2_cv <- mean(intraassays$crp_pl2, na.rm = TRUE)
crp_cv <- (crp_pl1_cv + crp_pl2_cv)/2

il1b_pl1_cv <- mean(intraassays$il1b_pl1, na.rm = TRUE)
il1b_pl2_cv <- mean(intraassays$il1b_pl2, na.rm = TRUE)
il1b_cv <- (il1b_pl1_cv + il1b_pl2_cv)/2

iga_pl1_cv <- mean(intraassays$iga_pl1, na.rm = TRUE)
iga_pl2_cv <- mean(intraassays$iga_pl2, na.rm = TRUE)
iga_cv <- (iga_pl1_cv + iga_pl2_cv)/2

##### Calculate inter-assay CVs (from 450 OD, not concentration) from the high and low controls.
interassays <- read_csv("EASE_immune_interassays.csv")
View(interassays)
# Calculate mean for controls by plate:
interassays$plate_mean <- rowMeans(interassays[,c(4:5)])

# CRP:
# Mean of high controls across plates:
crp_high_mean <- mean(data.matrix(interassays[interassays$marker=="crp"&interassays$control=="high","plate_mean"]))
# SD of high controls across plates:
crp_high_sd <- sd(data.matrix(interassays[interassays$marker=="crp"&interassays$control=="high","plate_mean"]))
# % CV high across plates:
crp_high_cv <- (crp_high_sd/crp_high_mean)*100
# Mean of low controls across plates:
crp_low_mean <- mean(data.matrix(interassays[interassays$marker=="crp"&interassays$control=="low","plate_mean"]))
# SD of low controls across plates:
crp_low_sd <- sd(data.matrix(interassays[interassays$marker=="crp"&interassays$control=="low","plate_mean"]))
# % CV low across plates:
crp_low_cv <- (crp_low_sd/crp_low_mean)*100
# AVERAGE % CV:
crp_inter_cv <- (crp_low_cv + crp_high_cv)/2

# IL-1B:
# Mean of high controls across plates:
il1b_high_mean <- mean(data.matrix(interassays[interassays$marker=="il1b"&interassays$control=="high","plate_mean"]))
# SD of high controls across plates:
il1b_high_sd <- sd(data.matrix(interassays[interassays$marker=="il1b"&interassays$control=="high","plate_mean"]))
# % CV high across plates:
il1b_high_cv <- (il1b_high_sd/il1b_high_mean)*100
# Mean of low controls across plates:
il1b_low_mean <- mean(data.matrix(interassays[interassays$marker=="il1b"&interassays$control=="low","plate_mean"]))
# SD of low controls across plates:
il1b_low_sd <- sd(data.matrix(interassays[interassays$marker=="il1b"&interassays$control=="low","plate_mean"]))
# % CV low across plates:
il1b_low_cv <- (il1b_low_sd/il1b_low_mean)*100
# AVERAGE % CV:
il1b_inter_cv <- (il1b_low_cv + il1b_high_cv)/2


# SIgA:
# Mean of high controls across plates:
iga_high_mean <- mean(data.matrix(interassays[interassays$marker=="iga"&interassays$control=="high","plate_mean"]))
# SD of high controls across plates:
iga_high_sd <- sd(data.matrix(interassays[interassays$marker=="iga"&interassays$control=="high","plate_mean"]))
# % CV high across plates:
iga_high_cv <- (iga_high_sd/iga_high_mean)*100
# Mean of low controls across plates:
iga_low_mean <- mean(data.matrix(interassays[interassays$marker=="iga"&interassays$control=="low","plate_mean"]))
# SD of low controls across plates:
iga_low_sd <- sd(data.matrix(interassays[interassays$marker=="iga"&interassays$control=="low","plate_mean"]))
# % CV low across plates:
iga_low_cv <- (iga_low_sd/iga_low_mean)*100
# AVERAGE % CV:
iga_inter_cv <- (iga_low_cv + iga_high_cv)/2
