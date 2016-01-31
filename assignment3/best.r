require('hash')

#define hash to lookup column numbers using strings
outcome_hash <- hash()
outcome_hash["heart attack"] <-  11
outcome_hash["heart failure"] <-  17
outcome_hash["pneumonia"] <-  23

best <- function(state, outcome) {
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
	
	#order the dataframe by mortality and then by hospital
	df = df[order(df$mortality, df$hospital), ]
	
	#return the first row as result
	head(df,1)
}	

best("TX","heart attack")
best("TX","heart failure")
best("MD","heart attack")
best("MD","pneumonia")