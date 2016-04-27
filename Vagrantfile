scripts_dir = "./scripts"

Vagrant.configure("2") do |config|
  config.vm.define :rt1 do |c|
    c.vm.box = "trusty_cloudimg64"
    c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    c.ssh.forward_agent = true
    c.vm.synced_folder "~/", "/mnt/shared_home"
    c.vm.network "private_network", ip: "192.168.175.100"
    c.vm.hostname = "rt1"
    c.vm.provision :shell, :path => File.join(scripts_dir, "rethinkdb.sh")
  end

  (2..4).each do |n|
    config.vm.define "rt#{n}".to_sym do |c|
      c.vm.box = "trusty_cloudimg64"
      c.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
      c.ssh.forward_agent = true
      c.vm.synced_folder "~/", "/mnt/shared_home"
      c.vm.network "private_network", ip: "192.168.175.#{n}"
      c.vm.hostname = "rt#{n}"
      c.vm.provision :shell, :path => File.join(scripts_dir, "rethinkdb.sh"), :args => "after_bootstrap"
    end
  end
end
