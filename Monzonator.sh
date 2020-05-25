#!/bin/bash

usage="./Monzonator.sh -l <language> -p <pages to pull> -n <num results per page>"
parse="F"
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


if [ ! -d "Results/${lang}" ]; then
	mkdir -p Results/$lang
fi

for ((i = 0; i <= $page; i++)); do
	curl -s "https://api.github.com/search/repositories?q=+language:${lang}&page=${i}&per_page=${numResult}&sort=desc&order=stars" | grep clone_url | cut -d '"' -f 4 >> Results/$lang/cloneURLS
done

cat Results/$lang/cloneURLS | sort -u > Results/$lang/cloners
rm Results/$lang/cloneURLS

cat Results/$lang/cloners | while read line; do
	mkdir Results/$lang/$(echo $line | cut -d "/" -f 5 | cut -d "." -f 1)
	git clone $line Results/$lang/$(echo $line | cut -d "/" -f 5 | cut -d "." -f 1)
	echo Results/$lang/$(echo $line | cut -d "/" -f 5 | cut -d "." -f 1) >> Results/$lang/dirlist
done

