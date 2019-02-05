for file in *.krn
do
	fields=$(grep '**kern' $file | awk '{print NF}')
	part_array=()
	entropy_array=()
	for ((i=1; i<fields; i++))
	do
		part=$(extractx -f $i $file | grep 'I\"' | sed 's/[\*\I"]//g' | sed 's/ /_/g')
		entropy=$(extract -f $i $file | infot -s | grep 'Average' | awk '{print $6}')
		part_array+=($part)
		entropy_array+=($entropy)
		echo "..."
	done
	for j in "${part_array[@]}"
	do
		printf "$j\t" >> $file.tmp
		echo "..."
	done
	printf "\n" >> $file.tmp
	for k in "${entropy_array[@]}"
	do
		printf "$k\t" >> $file.tmp
		echo "..."
	done
done
for file in *.tmp
do
	awk 'NF{NF-=1};1' <$file > $file.tsv
	echo "..."
done
rm *.tmp