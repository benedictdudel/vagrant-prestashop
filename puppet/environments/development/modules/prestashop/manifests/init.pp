class prestashop {

    exec { "download-prestashop-archive":
        cwd => "/tmp",
        command => "wget -q ${presta::prestashop_archive_url}",
        creates => "/tmp/${presta::prestashop_archive_name}",
    }

    exec { "unzip-prestashop-archive":
        cwd => "/var/www/",
        command => "unzip -qo /tmp/${presta::prestashop_archive_name}",
        require => Exec["download-prestashop-archive"],
    }

    exec { "unzip-prestashop":
        cwd => "/var/www/",
        command => "unzip -qo prestashop.zip",
        require => Exec["unzip-prestashop-archive"],
    }

    exec { "install-prestashop":
        cwd => "/var/www/install",
        command => "php index_cli.php \
            --language=\"en\" \
            --country=\"en\" \
            --domain=\"${presta::presta_site_url}\" \
            --db_server=\"localhost\" \
            --db_name=\"${presta::mysql_table}\" \
            --db_user=\"${presta::mysql_user}\" \
            --db_password=\"${presta::mysql_password}\" \
            --name=\"Development Store\" \
            --email=\"${presta::presta_email}\" \
            --password=\"${presta::presta_password}\" \
            --newsletter=0 >> error.txt",
        require => Exec["unzip-prestashop"],
    }

    file { "clean-up":
        ensure => absent,
        path => "/var/www/install",
        recurse => true,
        purge => true,
        force => true,
        require => Exec["install-prestashop"],
    }

    exec { "rename-admin-dir":
        cwd => "/var/www",
        creates => "/var/www/admin123",
        command => "mv admin admin123",
        require => File["clean-up"],
    }

    file { "/var/www/config/defines_custom.inc.php":
        source => "puppet:///modules/prestashop/defines_custom.inc.php",
        ensure => present,
        require => Exec["rename-admin-dir"],
    }

    exec { 'fix-permissions':
        command  => "chown -R www-data:www-data /var/www",
        onlyif   => 'ls -lhR /var/www/ | grep -i root',
        require  => File['/var/www/config/defines_custom.inc.php'],
    }

}
