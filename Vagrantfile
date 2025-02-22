# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
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
        web.vm.provision "shell", path: "vmweb_provisioning.sh"

        web.vm.provider "virtualbox" do |vb|
            vb.name = "web.m340"
            vb.memory = "2048"
            vb.cpus = 2
        end
    end

    # Configurazione VM db
    config.vm.define "db" do |db|
        db.vm.box = BOX_IMAGE
        db.vm.hostname = "db.m340"
        
        # Configurazione della rete
        db.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.11", virtualbox__intnet: "intnet"
        
        # Provisioning della macchina db
        db.vm.provision "shell", path: "vmdb_provisioning.sh"

        db.vm.provider "virtualbox" do |vb|
            vb.name = "db.m340"
            vb.memory = "2048"
            vb.cpus = 2
        end
    end
end
