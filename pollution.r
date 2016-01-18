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
get_dataframe_from_files <- function(files) {
	#this will return the combined csv files as a list of dataframes
	#df_list = lapply(files, read.delim)
	
	# First apply read.csv, then rbind
	# This will combine all files into one dataframe
	myfiles = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))
}

#this function calculated mean for all values in the given column
#for a datframe, ignoring the NAs
calculate_mean <- function(dataframe, column){
	m <- mean(dataframe[,column], na.rm = TRUE)
}

file_list <- get_files("~/code/r/r-experiments/specdata",1:4)
data_frame <- get_dataframe_from_files(file_list)
average <- calculate_mean(data_frame,'sulfate')

print(average)






