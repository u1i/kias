for d in $(seq 42 60)
do
  echo $d
  selget "http://DOMAIN/Genre/Movie?page=$d" page-$d.html
done
