Vagrant.configure("2") do |config|
  # Định nghĩa box và cấu hình cơ bản
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.boot_timeout = 600
  
  # Cấu hình mạng riêng tư
  config.vm.network "private_network", ip: "172.20.20.20"

  # Đồng bộ thư mục giữa host và guest
  config.vm.synced_folder "./", "/home/vagrant/myapp"

  # Cấu hình VirtualBox (RAM, chế độ không GUI)
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "4096"
  end

  # Script cài đặt phần mềm tự động
  config.vm.provision "shell", inline: <<-SHELL
    # Cập nhật gói cơ bản
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install -y curl gnupg2 ca-certificates lsb-release software-properties-common

    # Cài đặt Node.js (LTS)
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs

    # Cài đặt Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # Thêm user 'vagrant' vào nhóm Docker để không cần sudo khi chạy Docker
    sudo usermod -aG docker vagrant

    # Kích hoạt Docker service và đảm bảo chạy tự động sau khi khởi động
    sudo systemctl enable docker
    sudo systemctl start docker

   # Cài đặt Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose

   # Kiểm tra trạng thái dịch vụ
   echo "Kiểm tra trạng thái các dịch vụ..."
   sudo systemctl status docker || echo "Docker không chạy."
   docker ps
   docker-compose --version || echo "Docker Compose không cài đặt thành công."

    # Khởi chạy ứng dụng
    cd myapp
    docker-compose up --build
  SHELL
end