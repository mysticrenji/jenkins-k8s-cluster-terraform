# Jenkins running on AKS provisioned using Terraform

## 1. Provision Kubernetes Infrastruructure using Terraform
First we need to provision a kubernetes cluster. For the POC, I have used the AKS and provisioned it using Terraform. The complete steps are mentioned in the **Readme.md** under Terraform folder

## 2. Provision Jenkins on Kubernetes using Helm Charts
 Jenkins has been provisioned using helm charts. First we add the helm repo and update it. Create namespace specifically for Jenkins components to install NGINX Ingress controller and Jenkins chart. Values has been customized for Jenkins chart.
 ```
 cd Jenkins
 helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
 helm repo add jenkins https://charts.jenkins.io
 helm repo update
 # Use Helm to deploy an NGINX ingress controller
 kubectl create namespace jenkins
 helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace jenkins \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux
 helm install jenkins  jenkins/jenkins  --values values.yaml -n jenkins
 ```
## 3. Provision SonarQube on Kubernetes using Helm Charts
Sonarqube is provisioned using helm charts. The values are customized as well. Please execute below commands
```
cd SonarQube
helm repo add oteemocharts https://oteemo.github.io/charts/
helm repo update
kubectl create namespace sonarqube
helm install sonarqube -f sonarqube.yaml  oteemocharts/sonarqube -n sonarqube
```

## 4. Create Jenkins Declarative Pipeline
The pipeline has been written declaratively in the form of Jenkinsfile
