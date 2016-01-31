#set the working dir to current
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)


heart_attack_mortality_histogram <- function() {
	outcome = read.csv("./rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
	heart_attacks = as.numeric(outcome[,11])
	hist(heart_attacks)
}

heart_attack_mortality_histogram()