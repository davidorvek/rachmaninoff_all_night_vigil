rm *.tsv
rm *.tmp
for file in *.krn
do
	piece=$(grep '!!!OTL@EN' $file | cut -f 2)
	piece_file=$(grep '!!!OTL@EN' $file | cut -f 2 | sed 's/,//g' | sed 's/ /_/g')
	fields=$(grep '**kern' $file | awk '{print NF}')
	for ((i=1; i<=$fields; i++))
	do
		part=$(extractx -f $i $file | grep 'I\"' | sed 's/[\*\I"]//g' | sed 's/ /_/g')
		entropy=$(extractx -f $i $file | infot -s | grep 'Average' | awk '{print $6}')
		printf "$part\n$entropy" >> $piece_file$part.tmp
		echo "..."
	done
	for piece in piece_file*
	do
		paste $piece_file*Bass* $piece_file*Tenor* $piece_file*Alto* $piece_file*Soprano* >> $piece_file.tsv

	done
done
rm *.tmp
