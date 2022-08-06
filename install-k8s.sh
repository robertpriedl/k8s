
apt update && apt upgrade -y

sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo apt install docker.io --assume-yes
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker                                

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl -y
sudo apt-mark hold kubelet kubeadm kubectl

sudo swapoff -a
sudo sed -i '/swap/ s/^/#/' /etc/fstab

echo "to install cluster: kubeadm init --pod-network-cidr=10.244.0.0/16"
echo "to join cluster: kubeadm join 10.1.149.140:6443 --token yx8nnx.sf7ep8657f3j5j6r \
        --discovery-token-ca-cert-hash sha256:8185d65970297cce220dc35f549d6343ad12a385f2b71b925bf21dae24916921"
echo "change ip, token and discoverytoken from initial install"



