class mysql {

    package { 'mysql-client':
        ensure => present,
        require => Exec["apt-get update"],
    }

    package { 'mysql-server':
        ensure => present,
        require => Exec["apt-get update"],
    }

    service { "mysql":
        ensure => running,
        require => Package["mysql-server"],
    }

    exec { "change-bind-address":
        unless => "mysql -u${presta::mysql_user} -p${presta::mysql_password} ${presta::mysql_table}",
        command => "sed -i \"s/.*bind-address.*/bind-address = 0.0.0.0/\" /etc/mysql/my.cnf",
        require => Service["mysql"],
    }

    exec { "create-user":
        unless => "mysql -u${presta::mysql_user} -p${presta::mysql_password}",
        command => "mysql -uroot -e \"FLUSH PRIVILEGES;CREATE USER '${presta::mysql_user}'@'%' IDENTIFIED BY '${presta::mysql_password}';\"",
        require => Service["mysql"],
    }

    exec { "grant-access":
        unless => "mysql -u${presta::mysql_user} -p${presta::mysql_password} ${presta::mysql_table}",
        command => "mysql -uroot -e \"GRANT ALL PRIVILEGES ON *.* TO '${presta::mysql_user}'@'%';FLUSH PRIVILEGES;\"",
        require => Exec["create-user"],
    }

    exec { "create-db":
        unless => "mysql -u${presta::mysql_user} -p${presta::mysql_password} ${presta::mysql_table}",
        command => "mysql -u${presta::mysql_user} -p${presta::mysql_password} -e \"CREATE DATABASE ${presta::mysql_table};\"",
        require => [Exec["create-user"], Exec["grant-access"]],
    }

}
