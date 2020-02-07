dir$ = "/Users/haerimhwang/Desktop/re-recorded/"

n = numberOfSelected("Sound")
for i from 1 to n
s'i' = selected("Sound",'i')
s'i'$ = selected$("Sound",'i')
endfor

for i from 1 to n
n$ = s'i'$
select s'i'
Write to WAV file... 'dir$''n$'.wav
endfor

