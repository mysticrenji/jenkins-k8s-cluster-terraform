# Jenkins running on AKS provisioned using Terraform

## 1. Provision Kubernetes Infrastruructure using Terraform
First we need to provision a kubernetes cluster. For the POC, I have used the AKS and provisioned it using Terraform. The complete steps are mentioned in the **Readme.md** under Terraform folder

## 2. Provision Jenkins on Kubernetes using Helm Charts
 Jenkins has been provisioned using helm charts. The vaules files has been customized. Please follow the below command to install it
 ```
 cd Jenkins
 kubectl create namespace jenkins
 helm install jenkins  jenkins/jenkins  --values values.yaml -n jenkins
 ```
## 3. Provision SonarQube on Kubernetes using Helm Charts

## 4. Create Jenkins Declarative Pipeline
