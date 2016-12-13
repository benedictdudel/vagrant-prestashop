class tools {

    package { 'vim':
        ensure => present,
    }

    package { 'git':
        ensure => present,
    }

    package { 'wget':
        ensure => present,
    }

    package { 'curl':
        ensure => present,
    }

    package { 'unzip':
        ensure => present,
    }

    package { 'htop':
        ensure => present,
    }

}
