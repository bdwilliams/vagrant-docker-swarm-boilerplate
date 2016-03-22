Vagrant.configure(2) do |config|
  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.hostname = "vagrant.vm"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end
end