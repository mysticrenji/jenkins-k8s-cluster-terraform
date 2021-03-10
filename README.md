# Jenkins running on AKS provisioned using Terraform


Architecture
![Alt text](./Architecture.png?raw=true "Architecture")


## Pre-requisites
* Docker
* Kubernetes(AKS)
* Terraform
* Helm
* Azure Blob Storage

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
cd Sonarqube
helm repo add oteemocharts https://oteemo.github.io/charts/
helm repo update
kubectl create namespace sonarqube
helm install sonarqube -f values.yaml  oteemocharts/sonarqube -n sonarqube
```
Please note on configuring sonarqube token in Jenkins. Token can be created from Sonarqube portal with administrative privilege. </br>
The section can be found in Jenkins- >Configure System
![Alt text](./Sonarqube/SonarQube.png?raw=true "SonarQube")

Token Generation
![Alt text](./Sonarqube/Admins.png?raw=true "SonarToken")

## 4. Create Jenkins Declarative Pipeline
The pipeline has been written declaratively in the form of Jenkinsfile. The pipeline gets the source code from git repo and build simple a Java App inside a Maven container.

## To do List
* Add Master and Worker node monitoring using Prometheus and Grafana
* Add linting and tests for Terraform
* Inject 3rd party library scan using OWASP Dependency Check
* Add automated penentration testing after the deployment using OWASP ZAP
* Add extra layer of security by adding Approval Gates in the pipeline before the deployment
* Push the generated artifacts to external artifact repository such as JFrog, Sonar Nexus

## References
1. https://kubernetes.io/docs/home/
2. https://docs.microsoft.com/en-us/azure/aks/ingress-basic
3. https://www.terraform.io/intro/index.html
4. https://helm.sh/docs/
5. https://artifacthub.io/
