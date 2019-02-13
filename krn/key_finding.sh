for file in *.krn
do
	give=$(extractx -f 1 $file | grep '\*.*:' | sed 's/[\*\:]//g')
	ks=$(keycor -kk $file | awk '{print $5,$6}')
	aard=$(keycor --aarden $file | awk '{print $5,$6}')
	bell=$(keycor --bellman $file | awk '{print $5,$6}')
	temperley=$(keycor --temperley $file | awk '{print $5,$6}')
	euclid=$(keycor -h $file | awk '{print $5,$6}')
	first_bass=$(extractx -f 1 $file | pc -x | rid -GLId | grep -v '=' | sed 's/[\;\L\J\.]//g' | head -1)
	last_bass=$(extractx -f 1 $file | pc -x | rid -GLId | grep -v '=' | sed 's/[\;\L\J\.]//g' | tail -1)
	most_com=$(pc -x $file | rid -GLId | tr -s '\t' '\n' | grep -v '[\.=]' | sortcount | head -1 | awk '{print $2}')
	printf "$give\t$ks\t$aard\t$bell\t$temperley\t$euclid\t$first_bass\t$last_bass\t$most_com\n"
done