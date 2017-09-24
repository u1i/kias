trap ctrl_c INT

function ctrl_c() {
        echo "** Trapped CTRL-C"
	exit
}

d=$1

title=$(cat $d | sed "1,/<span class=\"title\">/d;" | sed "/<\/span>/,$ d")
img=$(grep "img src" $d | tr '"' "\n" | grep http | head -1)
href=$(grep "href" $d | tr '"' "\n" | grep Drama | head -1)

echo -e "\nTitle: $title"
echo Image: $img
echo Link: $href

country=""

attempt=0
while [ "$country" = "" ]
do

> movie.html
selget "http://DOMAIN/$href" movie.html

country=$(grep Country movie.html | grep href | tr '"' "\n" | grep Country | tail -1 | sed "s/.*\///;")
aired=$(grep "Date aired" movie.html | sed "s/.*span>//;")

[ "$attempt" -gt 0 ] && echo "Trying again ($attempt)"
attempt=$((attempt+1))

done

echo Country: $country
echo Aired: $aired

if [ "$country" = "" ]
then
    echo ERROR
    cp $d error/$RANDOM.$RANDOM.$RANDOM
else
    echo "<br>&nbsp;<br><a href='http://DOMAIN/$href'><img src='$img'><br>$title ($aired)</a>" >> out/$country.html
    mv $d DONE
fi
