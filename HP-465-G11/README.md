# 🛠️ Puppet Task: Corregir xfce-panel HP465G11

Esta tarea de Puppet automatiza la corrección de errores de interfaz y configuración de software en equipos **HP 465 G11** bajo el sistema operativo **Xubuntu 24.04 LTS**.

## 🚀 Funcionalidades

### 🖥️ Optimización de la Barra de Estado
*  Corrige los fallos de la barra de estado en los HP465G11 en Xubuntu22.04lts. Añade el icono de "PulseAudio" y elimina indicadores duplicados de Wifi y Bluetooth.
*  Pone por defecto la barra de estado corregida para nuevos usuarios ya creados que se encuentran en /home/alumnos/
*  Corrige el icono de Firefox que por defecto apunta a la versión de snapd, pero al desinstalarla ya no existe. Usaremos la versión instalada de Firefox en vez de la snapd.  

## 📂 Ubicación y Despliegue
*  Copia la carpeta íntegra "hp465g11_fix_xfce4_panel" a tu carpeta "modules"
*  Agrega el "include hp465g11_fix_xfce4_panel" al fichero "../modules/especifica_xubuntu2404/manifests/init.pp"
*  Ejecuta "puppet agent -tv" en el cliente
---
