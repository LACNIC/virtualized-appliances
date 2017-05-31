# Splunk for Data Analsys

Author: dario@lacnic.net

## Instalación en Vagrant

Entorno virtualizado en vagrant para la herrmienta de análisis de datos SPLUNK en la versión light.
Cuando se inicia por primera vez, el scritp actualiza e instala todos los paquetes necesarios para comenzar a usar el software.

**IMPORTANTE:** Es necesario descargar el archivo .deb (splunklight*.deb) del sitio del splunk para tener la última versión. (http://www.splunk.com/en_us/products/splunk-light.html)

### Caracteristicas

- Ubuntu Server 64 bits
- RAM: 2BG
- Http port: 8001
- Shh port: 2223

### Pasos para arrancar

Dentro de la carpeta raiz del proyecto, correr:

```
vagrant up --provision
```

## Instalación en Docker

Para instalar una instancia de docker con splunk se debe seguir el siguiente link: https://github.com/outcoldman/docker-splunk
