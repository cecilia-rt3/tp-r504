for i in $(seq 1 500); do
  echo -n "$i: "
  curl -s http://localhost:83
done

