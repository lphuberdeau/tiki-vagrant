# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.define :tiki, primary: true do |tiki|
		# Every Vagrant virtual environment requires a box to build off of.
		tiki.vm.box = "saucy64"
		tiki.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"

		# Boot with a GUI so you can see the screen. (Default is headless)
		# config.vm.boot_mode = :gui

		# via the IP. Host-only networks can talk to the host machine as well as
		# any other machines on the same network, but cannot be accessed (through this
		# network interface) by any external networks.
		tiki.vm.network :private_network, ip: "192.168.33.30"

		# Forward a port from the guest to the host, which allows for outside
		# computers to access the VM, whereas host only networking does not.
		tiki.vm.network :forwarded_port, host: 8012, guest: 8012
		tiki.vm.network :forwarded_port, host: 8013, guest: 8013
		tiki.vm.network :forwarded_port, host: 8014, guest: 8014
		tiki.vm.network :forwarded_port, host: 8015, guest: 8015

		# phpmyadmin
		tiki.vm.network :forwarded_port, host: 8100, guest: 8100

		tiki.vm.provision :puppet do |puppet|
			puppet.manifests_path = "manifests"
			puppet.manifest_file  = "tiki.pp"
		end
	end

	config.vm.define :elastic do |elastic|
		# Every Vagrant virtual environment requires a box to build off of.
		elastic.vm.box = "saucy64"
		elastic.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"

		# Boot with a GUI so you can see the screen. (Default is headless)
		# config.vm.boot_mode = :gui

		# via the IP. Host-only networks can talk to the host machine as well as
		# any other machines on the same network, but cannot be accessed (through this
		# network interface) by any external networks.
		elastic.vm.network :private_network, ip: "192.168.33.31"

		# Forward a port from the guest to the host, which allows for outside
		# computers to access the VM, whereas host only networking does not.
		elastic.vm.network :forwarded_port, host: 9200, guest: 9200

		elastic.vm.provision :puppet do |puppet|
			puppet.manifests_path = "manifests"
			puppet.manifest_file  = "elastic.pp"
		end
	end
end
