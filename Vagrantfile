# -*- mode: ruby -*-
# vi: set ft=ruby :

# Start the Jekyll server for local development on the guest:
#   cd /vagrant
#   jekyll serve --force_polling -H 0.0.0.0

Vagrant.configure(2) do |config|
  config.vm.box = "fedora/33-cloud-base"

  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.synced_folder ".", "/vagrant", type: "rsync"

  config.vm.provision :shell, path: "./setup.sh"
end
