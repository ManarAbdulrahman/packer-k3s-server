#!/bin/bash
sudo apt update -y && sudo apt install -y curl
sudo apt update -y && sudo apt install -y vim make git
sudo apt install  -y nmap ncat
curl -L get.docker.com | sh
sudo usermod -aG docker ubuntu
curl -sfL https://get.k3s.io | sh -
sudo systemctl enable k3s
sudo systemctl start k3s
sleep 5
#sudo cat /var/lib/rancher/k3s/server/token
#sudo cp /var/lib/rancher/k3s/server/token /home/ubuntu/token
#sudo chmod a+rw /home/ubuntu/token
#sudo chown ubuntu:ubuntu /home/ubuntu/token
sudo chmod a+r /etc/rancher/k3s/k3s.yaml
kubectl taint node $(hostname) k3s-controlplane=true:NoSchedule
#sudo cat <<EOF >> /usr/bin/print_token.sh
#sudo nc.traditional -e 'cat /var/lib/rancher/k3s/server/token' -lvvnk 1234
#EOF
sudo touch /lib/systemd/system/print_token.service
sudo cp /var/lib/rancher/k3s/server/token /home/ubuntu/token
sudo chmod a+r /home/ubuntu/token
#sudo cat <<EOF >> /home/ubuntu/print.sh
#!/bin/bash
#cat /home/ubuntu/token
#EOF
#sudo chmod a+x /home/ubuntu/print.sh
sudo cat <<EOF >> /home/ubuntu/print_token.service
[Unit]
Description=Example systemd service.

[Service]
Type=simple
ExecStart= ncat -e 'cat /home/ubuntu/token' -lvvkp 12345

[Install]
WantedBy=multi-user.target
EOF
sudo mv /home/ubuntu/print_token.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable print_token
sudo systemctl start print_token
