Vagrant.configure(2) do |config|
	config.vm.provision :shell, path: "bootstrap.sh", args: "#{ENV['PWD']}/volumes"
	config.vm.box = "phusion-open-ubuntu-14.04-amd64"
	config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"

	if Vagrant.has_plugin?("vagrant-cachier")
		config.cache.scope = :box
	end

	config.vm.define "vagrant1" do |vagrant1|
		vagrant1.vm.network "private_network", ip: "172.17.8.101", hostsupdater: "skip"
		vagrant1.vm.provision "shell", :path => "vagrant1/vagrant1.sh"
		vagrant1.vm.hostname = "vagrant1.vm"

		vagrant1.vm.provider "virtualbox" do |vb|
			vb.customize ["modifyvm", :id, "--memory", "1536"]
    	end
	end

	config.vm.define "vagrant2" do |vagrant2|
		vagrant2.vm.network "private_network", ip: "172.17.8.102", hostsupdater: "skip"
		vagrant2.vm.provision "shell", :path => "vagrant2/vagrant2.sh"
		vagrant2.vm.hostname = "vagrant2.vm"

		vagrant2.vm.provider "virtualbox" do |vb|
			vb.customize ["modifyvm", :id, "--memory", "1536"]
		end
	end

	config.vm.define "vagrant3" do |vagrant3|
		vagrant3.vm.network "private_network", ip: "172.17.8.103", hostsupdater: "skip"
		vagrant3.vm.provision "shell", :path => "vagrant3/vagrant3.sh"
		vagrant3.vm.hostname = "vagrant3.vm"

		vagrant3.vm.provider "virtualbox" do |vb|
			vb.customize ["modifyvm", :id, "--memory", "1536"]
    	end
	end
end