# 🛠️ Puppet Task: Mostrar mensaje de aviso de apagado antes de apagar el equipo

Esta tarea de Puppet crea un cron de apagado en los equipos en 3 horarios diferentes. 
En cada horario se avisa al usuario por pantalla que el equipo se va a apagar en 60 segundos, para que pueda guardar el trabajo actual y no perder la información.

## 🚀 Funcionalidades
Para que todos los usuarios (locales o de LDAP/NFS) autoricen automáticamente al usuario root a mostrar ventanas de Zenity en su sesión de XFCE, debes crear un script en el directorio de inicialización de X11.

### Crear el archivo de script
* Crea un nuevo archivo /etc/X11/Xsession.d/99allow-root-zenity (el número 99 asegura que se ejecute al final del proceso de carga), para permitir que el usuario root local acceda al servidor X del usuario actual
```
if [ -x /usr/bin/xhost ]; then
    /usr/bin/xhost +si:localuser:root > /dev/null
fi
```
* Ajustar permisos
Asegúrate de que el archivo tenga los permisos correctos para que el sistema pueda leerlo al iniciar la sesión:
```
$ chmod 644 /etc/X11/Xsession.d/99allow-root-zenity
```

### ¿Cómo funciona esto ahora?
A partir del próximo inicio de sesión, cualquier usuario que entre (aunque su /home esté en NFS) ejecutará este pequeño comando. Esto "abre la puerta" específicamente al root.
Ahora, desde una terminal como root, ya no necesitas hacer malabarismos con sudo -u usuario. 

* Puedes lanzar mensajes directamente así:
```
$ export XAUTHORITY=$(find /var/run/lightdm/root/ -type f -name ":0" 2>/dev/null | head -n 1); export DISPLAY=:0; /usr/bin/zenity --info --text="Mensaje" –title="Aviso"
```
* Si queremos programar un apagado en crontab:
```
00 22	* * *	root	export XAUTHORITY=$(find /var/run/lightdm/root/ -type f -name ":0" 2>/dev/null | head -n 1); export DISPLAY=:0; /usr/bin/zenity --info --text="El sistema se apagará en 60 segundos. Guarda tu trabajo ahora si no quieres perder información." --title="Aviso de Apagado"; /sbin/shutdown -h +1
```

## XAUTHORITY (para mostrar mensaje en la pantalla de login)
Cuando el greeter está activo, el servidor X utiliza un archivo de autoridad específico generado dinámicamente. Generalmente se encuentra en /var/run/lightdm/root/:0. Para que zenity funcione, debes indicar explícitamente dónde está este archivo mediante la variable XAUTHORITY
```
$ export XAUTHORITY=$(find /var/run/lightdm/root/ -type f -name ":0" 2>/dev/null | head -n 1)
```
**Un detalle importante:**
-  Al usar NFS, este método es el más limpio porque no intenta escribir nada en el directorio personal del usuario (evitando errores de cuotas de disco o permisos de escritura de NFS), simplemente cambia una regla en la memoria del servidor gráfico mientras la sesión está abierta.
