# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Variabili di configurazione
    BASE_INT_NETWORK = "10.10.20"
    BASE_HOST_ONLY_NETWORK = "192.168.56"
    BOX_IMAGE = "ubuntu/jammy64"

    # Configurazione VM Web
    config.vm.define "web" do |web|
        web.vm.box = BOX_IMAGE
        web.vm.hostname = "web.m340"
        
        # Configurazione della rete
        web.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.10", virtualbox__intnet: "intnet"
        web.vm.network "private_network", ip: "#{BASE_HOST_ONLY_NETWORK}.10", name: "VirtualBox Host-Only Ethernet Adapter"
        
        # Sincronizzazione della cartella per il sito
        web.vm.synced_folder "website", "/var/www/html"
        
        # Provisioning della macchina web
        web.vm.provision "shell", inline: <<-SHELL
            # Aggiornamento del sistema
            apt-get update -y
            apt-get upgrade -y

            # Installazione di Apache (web server)
            apt-get install -y apache2

            # Installazione di PHP e moduli aggiuntivi
            apt-get install -y php libapache2-mod-php php-mysql

            # Installazione di Adminer (per la gestione del DB)
            mkdir -p /var/www/html/adminer
            wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php

            # Riavvio di Apache
            systemctl restart apache2
        SHELL
    end

    # Configurazione VM Database
    config.vm.define "db" do |db|
        db.vm.box = BOX_IMAGE
        db.vm.hostname = "db.m340"
        
        # Configurazione della rete
        db.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.11", virtualbox__intnet: "intnet"
        
        # Provisioning della macchina database
        db.vm.provision "shell", inline: <<-SHELL
            # Aggiornamento del sistema
            apt-get update -y
            apt-get upgrade -y

            # Installazione di MySQL
            export DEBIAN_FRONTEND=noninteractive
            apt-get install -y mysql-server

            # Configurazione del database: creazione di un nuovo utente non root
            mysql -e "CREATE USER 'webuser'@'%' IDENTIFIED BY 'Password&1';"
            mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'webuser'@'%';"
            mysql -e "FLUSH PRIVILEGES;"

            # Configurazione del bind address per permettere connessioni remote
            sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
            systemctl restart mysql
        SHELL
    end
end
