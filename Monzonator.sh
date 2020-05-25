#!/bin/bash
#shout out do @Stark0de for the inspiration, check out his talk at https://www.youtube.com/watch?v=gK4BBxyU0pM

usage="./Monzonator.sh -l <language> -p <pages to pull> -n <num results per page>"
parse="F"
#handle args
while getopts "h:l:n:p:x" opt; do
	case $opt in
		l)
			lang=$OPTARG
			;;
		\?)
			echo "invalid opt" >&2
			exit 1
			;;
		:)
			echo "requires an arg" >&2
			exit 1
			;;
		n)
			numResult=$OPTARG
			;;
		p)
			page=$OPTARG
			;;
	esac
done

#create dirs if not created
if [ ! -d "Results/${lang}" ]; then
	mkdir -p Results/$lang
fi

#get repo list
for ((i = 0; i <= $page; i++)); do
	curl -s "https://api.github.com/search/repositories?q=+language:${lang}&page=${i}&per_page=${numResult}&sort=desc&order=stars" | grep clone_url | cut -d '"' -f 4 >> Results/$lang/cloneURLS
done

#avoid reruns
cat Results/$lang/cloneURLS | sort -u > Results/$lang/cloners
rm Results/$lang/cloneURLS

#clone repos into dirs and setup files for parser
cat Results/$lang/cloners | while read line; do
	mkdir Results/$lang/$(echo $line | cut -d "/" -f 5 | cut -d "." -f 1)
	git clone $line Results/$lang/$(echo $line | cut -d "/" -f 5 | cut -d "." -f 1)
	echo Results/$lang/$(echo $line | cut -d "/" -f 5 | cut -d "." -f 1) >> Results/$lang/dirlist
done

