require('hash')

#define hash to lookup column numbers using strings
outcome_hash <- hash()
outcome_hash["heart attack"] <-  11
outcome_hash["heart failure"] <-  17
outcome_hash["pneumonia"] <-  23

rankall <- function(outcome, num = "best") {
	data = read.csv("./rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")

	#validations

	#check if the outcome is correct
	if (!has.key(outcome,outcome_hash)){
		stop("invalid outcome")
	}

	#extract the rows for the state we need, and keep the columns for hospital, state and userdefined mortality
	df = data[ , c(2,7, outcome_hash[[outcome]]) ]
	
	#assign friendly names to columns
	colnames(df) <- c('hospital','state','mortality')
	
	#convert the mortality column into numeric type
	df$mortality = as.numeric(as.character(df$mortality))
	
	#removed rows where mortality is NA
	df = na.omit(df)

	#order the dataframe by mortality and then by hospital
	df = df[order(df$state, df$mortality, df$hospital), ]
	
	#Split the dataframe based on state
	df_list <- split( df , df$state )
	
	#return the first row as result
	
	if(num == "best") num <- 1
	
	if(num == "worst"){
		as.data.frame(do.call(rbind,  lapply(df_list, function(x){ x[ nrow(x) ,]} ) ))	
	}
	else{
		as.data.frame(do.call(rbind,  lapply(df_list, function(x){ x[num,]} ) ))
	}
}	

head(rankall("heart attack", 20), 10)
#tail(rankall("pneumonia", "worst"), 3)
#tail(rankall("heart failure"), 10)
