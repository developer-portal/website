# -*- mode: ruby -*-
# vi: set ft=ruby :

# Start the Jekyll server for local development on the guest:
#   cd /vagrant
#   jekyll serve --force_polling -H 0.0.0.0

Vagrant.configure(2) do |config|
  config.vm.box = "fedora-22-cloud"

  config.vm.provider :virtualbox do |virtualbox|
    config.vm.box_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-22-20150521.x86_64.vagrant-virtualbox.box"
  end

  config.vm.provider :libvirt do |libvirt|
    config.vm.box_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/22/Cloud/x86_64/Images/Fedora-Cloud-Base-Vagrant-22-20150521.x86_64.vagrant-libvirt.box"
  end if Vagrant.has_plugin?('vagrant-libvirt')

  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  config.vm.provision "shell", path: "setup.sh"
end
