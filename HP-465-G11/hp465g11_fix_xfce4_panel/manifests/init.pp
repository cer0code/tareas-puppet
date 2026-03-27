class hp465g11_fix_xfce4_panel {

# Convertimos el fact externo "alumnos_locales" en un array
  $lista_usuarios = split($facts['usuarios_locales'], ',')
 
	$lista_usuarios.each |$usuario| {
	    $base_path = "/home/alumnos/${usuario}"

      # 1. Copiar el archivo xfce4-panel.xml con el panel corregido
	    file { "${base_path}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml":
	      ensure  => file,
	      owner   => $usuario,
	      group   => $usuario,
	      mode    => '0644',
	      source  => "puppet:///modules/hp465g11_fix_xfce4_panel/xfce4-panel.xml",
	    }

	    file { "${base_path}/.config/xfce4/panel/":
              ensure  => directory,
              recurse => true,   # Copia subdirectorios y archivos recursivamente
              owner   => $usuario,
              group   => $usuario,
              mode    => '0655',
              source  => 'puppet:///modules/hp465g11_fix_xfce4_panel/panel', # Carpeta con los launchers
             }


	}

	# 3. Crear la estructura de directorios si no existe
	exec { "crear_directorio_xfce_skel":
		command => '/usr/bin/install -d -m 0755 -o root -g root /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/',
		creates => '/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/',
		path    => ['/usr/bin', '/bin'],
	}
	exec { "crear_directorio_panel_skel":
		command => '/usr/bin/install -d -m 0755 -o root -g root /etc/skel/.config/xfce4/panel/launcher-9/',
		creates => '/etc/skel/.config/xfce4/panel/launcher-9/',
		path    => ['/usr/bin', '/bin'],
	}

	# 4. Copia por defecto al skel el archivo xfce4-panel.xml
	file { "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" :
		owner => root , group => root , mode => '644' ,
		source => "puppet:///modules/hp465g11_fix_xfce4_panel/xfce4-panel.xml"
	}
 
	file { "/usr/share/linex-desktop-config/xfce4-panel.xml" :
		owner => root , group => root , mode => '644' ,
		source => "puppet:///modules/hp465g11_fix_xfce4_panel/xfce4-panel.xml"
	}

	file { "/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" :
		owner => root , group => root , mode => '644' ,
		source => "puppet:///modules/hp465g11_fix_xfce4_panel/xfce4-panel.xml"
	}

        # 5. Copia por defecto al skel el panel y el icono de Firefox corregido
	file { "/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" :
		owner => root , group => root , mode => '644' ,
		source => "puppet:///modules/hp465g11_fix_xfce4_panel/xfce4-panel.xml",
		require => Exec['crear_directorio_xfce_skel'],
	}

	# 6. Tarea para copiar múltiples directorios recursivamente
	file { '/etc/skel/.config/xfce4/panel/':
		ensure  => directory,
		source  => 'puppet:///modules/hp465g11_fix_xfce4_panel/panel', # Carpeta con los launchers
		recurse => true,   # Copia subdirectorios y archivos recursivamente
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		require => Exec['crear_directorio_xfce_skel'],
	}

}
