# Monzonator
Bash tool for pulling github repos of a target language, and a parser to search for vulnerable functions.
___
  <h3>First run Monzonator.sh to pull repos:</h3>
  
  Monzonator.sh -l (language) -p (pages to pull) -n (num results per page)

  <h3>then Monparse.sh to get a report of vulnerable functions across the repos:</h3>

  ./Monparse.sh -l (lang)
 
  Check source for editing tips and find some bugs!

<b>disclaimer: this downloads a whole lot of stuff so use caution on limited/metered connections</b>

Inspired by @stark0de's talk found here: https://www.youtube.com/watch?v=gK4BBxyU0pM
