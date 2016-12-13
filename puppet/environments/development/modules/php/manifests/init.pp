class php {

    $packages = [
        "php5",
        "php5-cli",
        "php5-xdebug",
        "php5-dev",
        "php5-mysqlnd",
        "php5-gd",
        "php5-curl",
        "php5-memcached",
        "php5-mcrypt",
        "libapache2-mod-php5",
    ]

    package { $packages:
        ensure => present,
        require => Exec["apt-get update"],
    }

    file { "/etc/php5/apache2/php.ini":
        source => "puppet:///modules/php/php.ini",
        require => Package["php5"],
        ensure => present,
    }

}
