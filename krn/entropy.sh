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
		printf "$part\n$entropy\n" >> $piece_file$part.tmp
		echo "..."
	done
done
rm *Solo*
for file in *Bass*
do
	cat $file | tail -1 >> all_bass.tmp

done
for file in *Tenor*
do
	cat $file | tail -1 >> all_tenor.tmp

done
for file in *Alto*
do
	cat $file | tail -1 >> all_alto.tmp

done
for file in *Soprano*
do
	cat $file | tail -1 >> all_soprano.tmp

done
printf "BASS\tTENOR\tALTO\tSOPRANO\n" > entropy.tsv
paste all_bass.tmp all_tenor.tmp all_alto.tmp all_soprano.tmp >> entropy.tsv
rm *.tmp
