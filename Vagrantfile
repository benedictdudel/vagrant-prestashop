Vagrant.configure("2") do |config|
    # Try to prevent 'stdin is not a tty' warnings
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Box
    config.vm.box = "puppetlabs/debian-8.2-64-puppet"

    # Network-specific configuration
    config.vm.hostname = "prestashop"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 3306, host: 3306

    # Shared directory
    config.vm.synced_folder "./src", "/var/www/modules/examplemodule",
        owner: "www-data",
        group: "www-data",
        mount_options: ["dmode=775,fmode=664"],
        create: true

    # Provider-specific configuration
    config.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
    end

    # Provisioner-specific configuration
    config.vm.provision :puppet do |puppet|
        puppet.environment_path = 'puppet/environments'
        puppet.environment = 'development'
    end

end
