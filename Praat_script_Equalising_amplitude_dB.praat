### equalising amplitude dB ### http://user.keio.ac.jp/~kawahara/scripts/equalize_amp_dB.praat ###
# It takes all the files in an input folder, and adjusts its amplitude to the specified dB value.

# This script takes all the files in the specified directory, modify their scales, and writes new files to a new folder
# It takes three arguments:
# InputDir is the original folder;
# positive dB is a dB value to which you want your files to be modified.

form Files
	sentence InputDir  /Users/haerimhwang/Desktop/Done/
	positive dB 65
endform

# It creates an output folder for you (called "output")

#createDirectory ("/Users/haerimhwang/Desktop/Done/output/")

# What Praat does for looping is first to create a string list and counts how many files there are in that list (find n).
# This allows us to do operation X for n-times.

Create Strings as file list... list 'inputDir$'*.wav
numberOfFiles = Get number of strings

# then it loops through, doing some actions for every file in the list.
# "for" is a function for loop.
# "ifile" means as follows:
# start i with 1 and do the operation that follows.
# change i to 2 and do the operation.
# change i to 3....
# keep until i becomes n.

for ifile to numberOfFiles

# The following three lines open i-th file in the string list

	select Strings list
	fileName$ = Get string... ifile
	Read from file... 'inputDir$''fileName$'

# THIS IS WHERE YOU SPECIFY THE OPERATION YOU WANT PRAAT TO DO

	Scale intensity... 'dB'

# Write the output file	(see your script folder)

	Write to WAV file... 'fileName$'
	
# This is for cleaning. You select everything minus the string list.
# And remove everything from the object window.	
	select all
	minus Strings list
	Remove

# This is the end of the loop.
endfor
select all
Remove

