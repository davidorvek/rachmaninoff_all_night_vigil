for file in *.krn
do
	title=$(grep '!!!OTL@EN' $file | awk 'BEGIN{FS=":"}{print $2}' | sed 's/^[[:space:]]*//g')
	key=$(extractx -f 1 $file | grep '\*.*:' | sed 's/[\*:mixdorphr]//g')
	mediant=$(awk -v awk_key=$key '$1 == awk_key {print $2}' mediants.txt)
	sonority -r $file | grep -v '[X=0-9\*\!rest]' >> all_chords.tmp
	sonority -r $file | grep -v '[X=0-9\*\!rest]' | grep "$mediant" >> mediants.tmp
	echo "..."
done
wc -l all_chords.tmp | awk '{print $1}' > number_of_chords.tmp
wc -l mediants.tmp | awk '{print $1}' > number_of_mediants.tmp
paste number_of_mediants.tmp number_of_chords.tmp > both.tmp
awk '{total = $1 / $2}{print total}' both.tmp
rm *.tmp