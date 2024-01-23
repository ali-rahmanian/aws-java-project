# Steps to run the experiment

# build and push dockerimage

> cd docker
> docker build -t node-hostname .
> docker tag node-hostname ravasimages/node-hostname:v1
> docker push ravasimages/node-hostname:v1

# Setup AWS:

> aws configure --profile terraform

# Setup kubectl and Helm

> aws eks --region us-east-1 update-kubeconfig --name demo --profile terraform

# Setup AWS EKS Cluster

> cd ./terraform
> terraform init
> terraform apply

# Install metrics-server in the cluster

> kubectl apply -f `https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`

# Install Application using Helm

> cd ./helm
> helm install node-hostname .
