###### This is based on the two scripts: 
###### 1) one by Brynn Hauk from the praat workshop in LING 632
###### 2) the other by Paul Boersma and David Weenink 
###### It was modifed by Bonnie Fox and Haerim Hwang 9/18/2017


## Set your directories:
form Analyze pitch of sound files 
  	 comment Directory of sound files
  	 text sound_directory /Users/haerimhwang/Desktop/Done/
  	 sentence Sound_file_extension .wav
 	 comment Full path of the resulting text file:
 	 text resultfile /Users/haerimhwang/Desktop/results.txt
endform


##  Check if the result file exists:
if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete "'resultfile$'"
endif


##  Write a row with column titles to the result file
##  (Remember to edit this if you add or change the analyses!):
titleline$ = "object_name	duration	'newline$'"
fileappend "'resultfile$'" 'titleline$'


##  Make a list of all the sound files in the directory we're using, 
##  and put the number of filenames into the variable "number_files":
Create Strings as file list...  list 'sound_directory$'*.wav
number_files = Get number of strings


##  Set up a "for" loop that will iterate once for every file in the list:
for j from 1 to number_files

	##  Query the file-list to get the first filename from it, then read that file in:
	select Strings list
	file_name$ = Get string... 'j'
    Read from file... 'sound_directory$''file_name$'

	## Make a variable called "object_name$" that will be equal to the filename minus the ".wav" extension:
    object_name$ = selected$ ("Sound")

	select Sound 'object_name$'
	startTime = Get start time
	endTime = Get end time
	duration = (endTime - startTime) 

	##  Save result to text file:
	resultline$ = "'object_name$'.wav	'duration'	'newline$'"
	
	fileappend "'resultfile$'" 'resultline$'

		
endfor

##  Clean up all files on the list: 
select all
Remove

##  Show if the process is completed:
print All files have been processed.













