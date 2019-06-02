#!/bin/sh
sudo swapoff -a
sudo apt-get update
sudo apt-get install -y docker.io apt-transport-https curl
sudo /bin/systemctl enable docker.service
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

#Only for node:
JOIN_COMMAND=`curl 10.0.1.13/kubernetes/join`
sudo $JOIN_COMMAND
