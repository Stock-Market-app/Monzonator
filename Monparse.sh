#!/bin/bash
lang=""
#handle flags
while getopts ":l:" opt; do
	case $opt in
		l)
			lang=$OPTARG
			;;
		\?)
			echo "invalid opt" >&2
			exit 1
			;;
		:)
			echo "specify language"
			exit 1
			;;
		h)
			echo "./Monparse -l <lang> supported: c,php,python"
			exit 1
			;;
	esac
done

#check for monzonator results
if [ ! -d "Results/${lang}" ]; then
	echo "looks like you need the Monzonator!"
	exit 1
fi

#grep for vulnerable functions <<THIS IS WHAT YOU EDIT IF YOU WANT TO SEARCH FOR DIFFERENT THINGS>>
#its also super easy to add language support for both of these scripts.
case "$lang" in
	php)
		vuln="exec(\|system(\|passthru(\|eval(\|require(\|include(\|file_get_contents\|move_uploaded_file\|unserialize\|SELECT.*FROM"
		ext="php"
		;;
	c)
		vuln="gets\|strcpy\|sprintf\|strcat\|getpw\|SELECT.*FROM\|memchr\|scanf"
		ext="c"
		;;
	cpp)
		vuln="strcpy\|sprintf\|gets\|strcat\|getpw\|SELECT.*FROM\|scanf\|memchr"
		ext="cpp"
		;;
	csharp)
		vuln="SELECT.*FROM\|XmlDocument("
		ext="cs"
		;;
	python)
		vuln="os.popen(\|subprocess.Popen(\|exec(\|SELECT.*FROM\|pickle.load(\|eval(\|input(\|str.format(\|os.system(\|yaml.load(\|file(\|open(\|shelve("
		ext="py"
		;;
esac

#search results and compile "reports"
echo "Processing..."
cat Results/$lang/dirlist | while read line; do
	find $line -name "*.${ext}" > $line/target_files
	cat $line/target_files | while read line1; do
		grep $vuln $line1 /dev/null --color=always -n -s >> $line/vulnerability_results
	done
	cat $line/vulnerability_results| cut -d ":" -f 1| uniq -c | sort -n -r >> $line/MonReport
done
#create overview and output
echo "Full Results (individual reports in project folders)"
cat Results/$lang/*/MonReport | sort -n -r >> Results/$lang/FullReport
cat Results/$lang/FullReport
