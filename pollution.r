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
get_dataframes_from_files <- function(files) {
	df = lapply(files, read.delim)
}

file_list <- get_files("/Users/shaunak/code/r/r-experiments/specdata",1:332)
data_frames <- get_dataframes_from_files(file_list) 





