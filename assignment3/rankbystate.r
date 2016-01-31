require('hash')

#define hash to lookup column numbers using strings
outcome_hash <- hash()
outcome_hash["heart attack"] <-  11
outcome_hash["heart failure"] <-  17
outcome_hash["pneumonia"] <-  23

rankhospital <- function(state, outcome, num = "best") {
	data = read.csv("./rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")

	#validations
	#check if state is correct
	if (!state %in% data[,7]){
		stop("invalid state")
	}

	#check if the outcome is correct
	if (!has.key(outcome,outcome_hash)){
		stop("invalid outcome")
	}

	#extract the rows for the state we need, and keep the columns for hospital, state and userdefined mortality
	df = data[data$State == state,   c(2,7, outcome_hash[[outcome]]) ]
	
	#assign friendly names to columns
	colnames(df) <- c('hospital','state','mortality')
	
	#convert the mortality column into numeric type
	df$mortality = as.numeric(as.character(df$mortality))
	
	#removed rows where mortality is NA
	df = na.omit(df)

	#order the dataframe by mortality and then by hospital
	df = df[order(df$mortality, df$hospital), ]
	
	#return the first row as result
	if(num == "worst") num <- nrow(df)
	else if(num == "best") num <- 1
		
	df[num, "hospital"]
	
}	

#rankhospital("TX","heart failure", 4)
rankhospital("MD","pneumonia", "best")
