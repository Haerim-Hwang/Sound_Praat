### This is based on a script from the praat workshop in LING 632 from the part by Brynn Hauk 
### It was modifed by Bonnie Fox and Haerim Hwang 9/12/2017

## Set your directories:
form Analyze pitich of sound files 
	comment Directory of sound files
	text sound_directory /Users/Haerim/Desktop/2017Fall/LING632/Praat_script/wav/
	sentence Sound_file_extension .wav
	comment Directory of pitch files
	text pitch_directory /Users/Haerim/Desktop/2017Fall/LING632/Praat_script/pitch/
	comment Full path of the resulting text file:
	text resultfile /Users/Haerim/Desktop/2017Fall/LING632/Praat_script/wav/results.txt
endform


## Check if the result file exists:
if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete "'resultfile$'"
endif

## Write a row with column titles to the result file
## (Remember to edit this if you add or change the analyses!):

titleline$ = "'object_name$'	tmin	tmax	mean	minimum	maximum	stdev	'newline$'"
fileappend "'resultfile$'" 'titleline$'


##  Now we make a list of all the sound files in the directory we're using, and put the number of
##  filenames into the variable "number_of_files":

Create Strings as file list...  list 'sound_directory$'*.wav
number_files = Get number of strings

## Then we set up a "for" loop that will iterate once for every file in the list:

for j from 1 to number_files

## Query the file-list to get the first filename from it, then read that file in:
     select Strings list
     file_name$ = Get string... 'j'
     Read from file... 'sound_directory$''file_name$'

     ## Here we make a variable called "object_name$" that will be equal to the filename minus the ".wav" extension:
     object_name$ = selected$ ("Sound")


##  Creates the complete pitch contour (i.e., you select the Sound and choose To Pitch...)
	select Sound 'object_name$'
	To Pitch: 0.000, 75, 500
	select Pitch 'object_name$'
	Write to short text file... 'pitch_directory$''object_name$'.pitch

endfor


## This is based on a script by Paul Boersma and David Weenink 
## It was modifed by Bonnie Fox and Haerim Hwang 9/12/2017
## This script does the following:
### 1) splits the wave into 50 msec sections;Open each sound file in the directory:

Create Strings as file list...  list 'pitch_directory$'*.pitch
number_files = Get number of strings


## Then we set up a "for" loop that will iterate once for every file in the list:

for j from 1 to number_files

	select Strings list
	file_name$ = Get string... 'j'
	Read from file... 'pitch_directory$''file_name$'

## Here we make a variable called "object_name$" that will be equal to the filename minus the ".wav" extension:
	object_name$ = selected$ ("Pitch")
  
	select Pitch 'object_name$'
	startTime = Get start time
	endTime = Get end time
	numberOfTimeSteps = (endTime - startTime) / 0.05
	writeInfoLine: "object tmin tmax mean fmin fmax stdev"
	for step to numberOfTimeSteps
    	tmin = startTime + (step - 1) * 0.05
    	tmax = tmin + 0.05

## 2) then for each of those sections gets the F0 statistics;
## 	  That is, for each 50 msec section of speech it gets the average F0, min, max, and standard deviation
    	mean = Get mean: tmin, tmax, "Hertz"
    	minimum = Get minimum: tmin, tmax, "Hertz", "Parabolic"
    	maximum = Get maximum: tmin, tmax, "Hertz", "Parabolic"
    	stdev = Get standard deviation: tmin, tmax, "Hertz"


	## Save result to text file:
						resultline$ = "'object_name$'	'tmin'	'tmax'	'mean'	'minimum'	'maximum'	'stdev'	'newline$'"
					fileappend "'resultfile$'" 'resultline$'

	endfor
endfor

# And at the end, a little bit of clean up and a message to let you know that it's all done.


select all
Remove

print All files have been processed.













