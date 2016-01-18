# function returns a file list as string given a directory
# and ID of files to fetch
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
	myfiles = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))
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
	
	#to add a new row
	#df = rbind(df,data.frame(id = 8, nobs = 567))

	#get complete cases for each dataframes and add them as a row in new df
	for(i in seq_along(dataframe_list)){
		df = rbind(df,data.frame(id = i, nobs = count_complete_cases(dataframe_list[[i]])  ))		
	}

	df
}


#data we need to calculate stuff we need
file_list 	<- get_files("~/code/r/r-experiments/specdata",c(2, 4, 8, 10, 12))
data_frame 	<- merged_data_frame(file_list)
data_frame_list <- get_dataframe_list_from_files(file_list)

#things we need
average 	<- calculate_mean(data_frame,'sulfate')
complete_cases <- list_complete_cases(data_frame_list) 

#print out the results
sprintf("Average : %f",average)
print("Complete Cases :")
print(complete_cases)






