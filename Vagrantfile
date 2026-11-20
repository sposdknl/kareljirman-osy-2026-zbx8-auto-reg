IMAGE_NAME = "bento/debian-13"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 4
    end

    config.vm.define "debian" do |debian|
        debian.vm.box = IMAGE_NAME
        debian.vm.network "forwarded_port", guest: 22, host: 2206, host_ip: "127.0.0.1"
        debian.vm.hostname = "debian13"
    end

    # Instalace Zabbix Agent 2 8.0 LTS
    config.vm.provision "shell", path: "install-zabbix-agent2.sh"

    # Konfigurace agenta a automatická registrace
    config.vm.provision "shell", path: "configure-zabbix-agent2.sh"

end
