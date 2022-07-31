# OSSec

>Team: BAJ

<br>

>We have designed an OSS inspector tool which will help us to identify the genuineness of the repos and perform a security health check. 

It basically is a bash tool for pulling github repos of a target language, and a parser to search for vulnerable functions.
___
  <h3>First run OSSec.sh to pull repos:</h3>
  
  OSSec.sh -l (language) -p (pages to pull) -n (num results per page)

  <h3>Then OSSecParse.sh to get a report of vulnerable functions across the repos:</h3>

  ./OSSecParse.sh -l (lang)
 
  Check source for editing tips and find some bugs!

<b>Disclaimer: this downloads a whole lot of stuff so use caution on limited/metered connections</b>

>References:
Inspired by @stark0de's talk found here: https://www.youtube.com/watch?v=gK4BBxyU0pM
