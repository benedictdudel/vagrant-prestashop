class ngrok {

    $ngrok_archive_name = "ngrok-stable-linux-amd64.zip"
    $ngrok_archive_url = "https://bin.equinox.io/c/4VmDzA7iaHb/${ngrok_archive_name}"

    exec { "download-ngrok-archive":
        cwd => "/tmp",
        command => "wget -q ${ngrok_archive_url}",
        creates => "/tmp/${ngrok_archive_name}",
    }

    exec { "unzip-ngrok-archive":
        cwd => "/usr/local/bin",
        command => "unzip -qo /tmp/${ngrok_archive_name}",
        creates => "/user/local/bin/ngrok",
        require => Exec["download-ngrok-archive"],
    }

}
