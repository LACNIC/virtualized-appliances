# dsc-influx-import

dsc is the *DNS statistics collector*, influxDB is a very well known timeseries database. This container includes scripting and dependencies that allow processing XML files collected by dsc and to import the result into an influxDB instance.

## Usage

### Build

```shell
./build.sh
```

### Run

To run the full pipeline ( fetch && process && post)

```bash
DATE=YYYY-MM-DD PROFILE={d.ip6 | d.in-addr} ./pipeline.sh
```

To run a specific stage

```shell
DATE=YYYY-MM-DD PROFILE={d.ip6 | d.in-addr} ./{fetch | process | post}.sh
```

## Notes

Docker for Mac struggles with IPv6, so when running this scripts from Docker for Mac the Influx service has to be exposed on an IPv4 address.