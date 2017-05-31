docker rm influxdb
docker run -d -p 8083:8083 -p 8086:8086 \
  -e PRE_CREATE_DB="wadus" \
  --expose 8090 --expose 8099 \
  --name influxdb \
  --hostname influxdb \
  tutum/influxdb

docker rm grafana
docker run -d -p 3000:3000 \
  --link influxdb:influxdb \
  --name grafana \
  --hostname grafana \
  grafana/grafana

# open browser

open http://localhost:3000
