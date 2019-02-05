for file in *.krn
do
	key=$(extractx -f 1 $file | grep '\*.*:' | sed 's/[\*:]//g')
	mediant=$(awk -v awk_key=$key '$1 == awk_key {print $2}' mediants.txt)
	roots=$(sonority -r $file)
done