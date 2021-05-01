

stress_alpha <- alpha((ease_dass[, c("DASS_1", "DASS_22", "DASS_6", "DASS_27", "DASS_8", "DASS_29", 
                                     "DASS_11", "DASS_32", "DASS_12", "DASS_33", "DASS_14", 
                                     "DASS_35", "DASS_18", "DASS_39")]))

anxiety_alpha <- alpha((ease_dass[, c("DASS_2", "DASS_23", "DASS_4", "DASS_25", "DASS_7", "DASS_28", 
                                     "DASS_9", "DASS_30", "DASS_15", "DASS_36", "DASS_19", 
                                     "DASS_40", "DASS_20", "DASS_41")]))

depression_alpha <- alpha((ease_dass[, c("DASS_3", "DASS_24", "DASS_5", "DASS_26", "DASS_10", "DASS_31", 
                                     "DASS_13", "DASS_34", "DASS_16", "DASS_37", "DASS_17", 
                                     "DASS_38", "DASS_21", "DASS_42")]))

pss_alpha <- alpha(ease_pss[, c("PSS_1","PSS_2","PSS_3","PSS_4","PSS_5","PSS_6","PSS_7","PSS_8","PSS_9",
                                "PSS_10","PSS_11","PSS_12","PSS_13","PSS_14")], 
                   keys=c("PSS_4","PSS_5","PSS_6","PSS_7","PSS_9","PSS_10","PSS_13"))
