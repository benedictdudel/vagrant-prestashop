class apache {

    package { "apache2":
        ensure => present,
        require => Exec["apt-get update"],
    }

    service { "apache2":
        ensure => running,
        enable => true,
        require => Package["apache2"],
        subscribe => [
            File["/etc/apache2/mods-enabled/rewrite.load"],
            File["/etc/apache2/sites-available/000-default.conf"],
            File["/etc/php5/apache2/php.ini"]
        ],
    }

    file { "/etc/apache2/mods-enabled/rewrite.load":
        ensure => link,
        target => "/etc/apache2/mods-available/rewrite.load",
        require => Package["apache2"],
    }

    file { "/etc/apache2/sites-available/000-default.conf":
        ensure => present,
        source => "puppet:///modules/apache/000-default.conf",
        require => Package["apache2"],
    }

    file { "remove-default-document-root":
        ensure => absent,
        path => "/var/www/html",
        recurse => true,
        purge => true,
        force => true,
        require => Service["apache2"],
    }

}
