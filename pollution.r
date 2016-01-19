####
#
#Library of utility functions we will need to put together the functions needed 
#to answer the quiz
#
#####


# function returns a file list as string given a directory and ID of files to fetch
get_files <- function(directory,id = 1:332) {
	#fetch all files in the a directory
	file.names <- list.files(directory, full.names = TRUE)
  	
	#from the file names get a list of numbers
  	file.numbers <- as.numeric(sub('\\.csv$','', basename(file.names)))
  	
  	#from the number vector match the numbers we need from id arguement
  	#and use it to select only those file names
  	selected.files <- na.omit(file.names[match(id, file.numbers)])
}

# function returns a merged data-frame given a R file list as string
merged_data_frame <- function(files) {
	# First apply read.csv, then rbind
	# This will combine all files into one dataframe
	df = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))
}

# function returns a list of data-frames given a R file list as string
get_dataframe_list_from_files <- function(files) {
	#this will return the combined csv files as a list of dataframes
	df_list = lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE))
}

#this function calculated mean for all values in the given column
#for a datframe, ignoring the NAs
calculate_mean <- function(dataframe, column){
	m <- mean(dataframe[,column], na.rm = TRUE)
}

#Function counts the number of complete cases for a dataframe
count_complete_cases <- function(dataframe){
	#logical vector of TRUE and FALSES to show which cases are complete
	l <- complete.cases(dataframe)
	#count complete (TRUE) cases (values)
	count <- length(l[l==TRUE])
}


#this function finds the number of complete observations (none of the columns is NA) in the dataframe and returns the 
#result as a new dataframe of the form:
# 	 id nobs
# 1  2 1041
# 2  4  474
list_complete_cases <- function(dataframe_list){
	df <- data.frame(id = integer(0), nobs = integer(0))
	
	#how to add a new row?
	#df = rbind(df,data.frame(id = 8, nobs = 567))

	#get complete cases for each dataframes and add them as a row in new df
	for(i in seq_along(dataframe_list)){
		df = rbind(df,data.frame(id = i, nobs = count_complete_cases(dataframe_list[[i]])  ))		
	}

	df
}

# http://www.inside-r.org/r-doc/stats/cor
# takes a complete threshold , and calculates covarience for
# all dataframes that pass this threshold
# returns the correlation as a vector
get_corelations <- function(dataframes,threshold=0) {
	cor_vector <- numeric(0)
	
	for(i in seq_along(dataframes)){
		df <- dataframes[[i]]
		if (count_complete_cases(df) > threshold){
			cor_vector <- c(   cor_vector, cor( df[,'sulfate'], df[,'nitrate'], use = "complete.obs" )   )
		}
	}

	cor_vector	
}

####
#
#Finally lets use above functions and write functions needed in quiz to answer the question
#
#####

DATA_LOCATION <- "~/code/r/r-experiments/specdata"

#Part 1
pollutantmean <- function(pollutant,id=1:332) {
	file_list 	<- get_files(DATA_LOCATION,id)
	data_frame 	<- merged_data_frame(file_list)
	m <- calculate_mean(data_frame,pollutant)		
}

#Part 1 test cases
#print(pollutantmean("sulfate", 1:10))
#print(pollutantmean("nitrate"))
#print(pollutantmean("sulfate", 34))
#print(pollutantmean("sulfate", 1:10))



#Part 2
complete <- function(id) {
	file_list 	<- get_files(DATA_LOCATION,id)
	data_frame_list <- get_dataframe_list_from_files(file_list)
	complete_cases <- list_complete_cases(data_frame_list) 
}

#Part 2 test cases
#print(complete(1))
#print(complete(c(2, 4, 8, 10, 12)))
#print(complete(30:25))
#print(complete(3))
# cc <- complete(54)
# print(cc$nobs)




#Part 3
corr <- function(threshold=0) {
	file_list 	<- get_files(DATA_LOCATION)
	data_frame_list <- get_dataframe_list_from_files(file_list)
	cr_vector <- get_corelations(data_frame_list,threshold)
}

#Part 3 test cases

 #cr <- corr(150)
 #print(cr)
 #print(head(cr))
#print(summary(cr))

# cr <- corr(400)
# print(head(cr))
# print(summary(cr))


# cr <- corr(5000)
# print(summary(cr))
# print(length(cr))


# cr <- corr()
# print(summary(cr))
# print(length(cr))

# cr <- corr(129)                
# cr <- sort(cr)                
# n <- length(cr)                
# set.seed(197)                
# out <- c(n, round(cr[sample(n, 5)], 4))
# print(out)

cr <- corr(2000)                
n <- length(cr)                
cr <- corr(1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))