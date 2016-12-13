class presta {

    $mysql_table = "prestashop"
    $mysql_user = "prestashop"
    $mysql_password = "prestashop"

    $presta_site_url = "127.0.0.1:8080"
    $presta_email = "dev@prestashop.com"
    $presta_password = "prestashop"

    $prestashop_archive_name = "prestashop_1.7.0.2.zip"
    $prestashop_archive_url = "https://download.prestashop.com/download/old/${prestashop_archive_name}"

    Exec {
      path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
    }

    exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
    }

    include tools
    include mysql
    include php
    include apache
    include phpmyadmin
    include prestashop
    include ngrok

}

include presta
