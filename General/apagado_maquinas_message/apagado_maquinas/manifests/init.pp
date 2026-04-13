class apagado_maquinas {

# Fichero para que todos los usuarios (locales o de LDAP/NFS) autoricen automáticamente al usuario root a mostrar ventanas de Zenity en su sesión de XFCE
  file {"/etc/X11/Xsession.d/99allow-root-zenity" :
           owner => root , group => root , mode => '644' ,
           source => "puppet:///modules/apagado_maquinas/99allow-root-zenity"
  }

#Apagado de máquinas por la mediodía.
        cron { apagado-mediodia:
#        command => "/sbin/shutdown -h now",
        command => "root export XAUTHORITY=$(find /var/run/lightdm/root/ -type f -name ':0' 2>/dev/null | head -n 1) && export DISPLAY=:0 && (/usr/bin/zenity --warning --text='El sistema se apagará en 60 segundos. Guarda tu trabajo ahora si no quieres perderlo.' --title='Aviso de Apagado' &) ; /sbin/shutdown -h +1",
        user => root,
        hour => 14,
        minute => 35,
	ensure => present,
	}

#Apagado de máquinas por la tarde
        cron {  apagado-tarde:
#        command => "/sbin/shutdown -h now",
        command => "root export XAUTHORITY=$(find /var/run/lightdm/root/ -type f -name ':0' 2>/dev/null | head -n 1) && export DISPLAY=:0 && (/usr/bin/zenity --warning --text='El sistema se apagará en 60 segundos. Guarda tu trabajo ahora si no quieres perderlo.' --title='Aviso de Apagado' &) ; /sbin/shutdown -h +1",
        user => root,
        hour => 16,
        minute => 30,
        ensure => present,
        }

#Apagado de máquinas por la noche
        cron {  apagado-noche:
#        command => "/sbin/shutdown -h now",
        command => "root export XAUTHORITY=$(find /var/run/lightdm/root/ -type f -name ':0' 2>/dev/null | head -n 1) && export DISPLAY=:0 && (/usr/bin/zenity --warning --text='El sistema se apagará en 60 segundos. Guarda tu trabajo ahora si no quieres perderlo.' --title='Aviso de Apagado' &) ; /sbin/shutdown -h +1",
        user => root,
        hour => 23,
        minute => 50,
	ensure => present,
	}

}
