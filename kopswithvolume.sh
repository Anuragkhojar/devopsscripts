#vi .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

#ssh-keygen
#cp /root/.ssh/id_rsa.pub my-keypair.pub
#chmod 777 my-keypair.pub

#vi kops.sh


curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl&quot"
wget https://github.com/kubernetes/kops/releases/download/v1.32.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops
aws s3api create-bucket --bucket khojar-kops-testbkt1433.k8s.local --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
aws s3api put-bucket-versioning --bucket khojar-kops-testbkt1433.k8s.local --region ap-south-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://khojar-kops-testbkt1433.k8s.local
kops create cluster --name=khojar.k8s.local --zones=ap-south-1a --control-plane-count=1 --control-plane-size=t3.medium --node-count=2 --node-size=t3.small --node-volume-size=20 --control-plane-volume-size=20 --ssh-public-key=my-keypair.pub --image=ami-0f918f7e67a3323f0 --networking=calico
kops update cluster --name khojar.k8s.local --yes --admin





#wq!

#export KOPS_STATE_STORE=s3://khojar-kops-testbkt1433.k8s.local
#kops validate cluster --wait 10m
