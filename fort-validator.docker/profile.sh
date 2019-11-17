clear
# print help

echo Clean with:
echo cat memdata_fort.csv  | cut -d " " -f 2 | sed 's/MiB//' | sed 's/B//'

rm memdata_fort.csv || /usr//bin/true

while true
do
	docker stats --no-stream --format "{{.Container}}, {{.MemUsage}}" | tee -a memdata_fort.csv
	sleep 1
done

