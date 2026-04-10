#!/bin/bash
# Obtiene los usuarios con UID >= 1000 y que tienen un directorio en /home
echo -n "usuarios_locales="
ls /home/alumnos | tr '\n' ',' | sed 's/,$//'
