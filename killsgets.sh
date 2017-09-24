while [ 1 ]
do
date
sgets=$(ps auxwww | grep selget | grep -v grep | awk ' { print $2; } ')
for p in $sgets
do
	age=$(ps -o etime= -p "$p" | tr -d ":")
	echo Process: $p Age: $age

	if [ "$age" -gt "30" ]
	then
		kill -9 $p
	fi
done
sleep 5
done
