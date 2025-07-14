# Add Admin IAM ROLE to EC2
#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.32.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops
aws s3api create-bucket --bucket khojar-kops-testbkt143.k8s.local --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
aws s3api put-bucket-versioning --bucket khojar-kops-testbkt143.k8s.local --region ap-south-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://khojar-kops-testbkt143.k8s.local
kops create cluster --name khojar.k8s.local --zones ap-south-1a --image ami-0f918f7e67a3323f0  --control-plane-count=1 --control-plane-size t2.medium --node-count=2 --node-size t2.micro
kops update cluster --name khojar.k8s.local --yes --admin

#kops validate cluster --wait 10m
