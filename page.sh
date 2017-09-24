rm xx*
page=$1

cat $page | sed "1,/<div class=\"list-drama\">/d;" | sed "/script type/,$ d" > page.items

gcsplit page.items '/<div class="item/' '{*}'

# awk '/<div class="item"/{filename=NR".txt"}; {print >filename}' p58.html.2

rm xx00
grep -ils "item last" xx* | xargs rm

for movie in xx*
do
  ./movie.sh $movie
done
