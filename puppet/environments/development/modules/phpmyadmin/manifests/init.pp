class phpmyadmin {

    package { "phpmyadmin":
        ensure  => present,
        require => [
            Package["php5", "apache2"],
        ]
    }

    file { "/var/www/phpmyadmin":
        ensure => link,
        target => "/usr/share/phpmyadmin",
        require => Package['apache2'],
    }

}
