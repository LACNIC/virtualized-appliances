#!/bin/bash
curl -i -XPOST 'http://179.0.156.40:8086/write?db=dsc&u=datosdsc&p=dsc2017datos' --data-binary @$1
