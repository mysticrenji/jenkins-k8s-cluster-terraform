## 1.Azure Service Principal Creation
az ad sp create-for-rbac -n "SP" --role Owner --scopes /subscriptions/{SubID}/resourceGroups/{ResourceGroup1}  </br>

## 2.Export Service principal credentials from the query above
export AZURE_SUBSCRIPTION_ID=''</br>
export AZURE_TENANT_ID=''</br>
export AZURE_CLIENT_ID=''</br>
export AZURE_CLIENT_SECRET=''</br>

## 3.Create Azure Blob Storage to act as Terraform Remote Backend
Edit the blobstoragecreation.sh and update values, then execute. Save the results</br>

## 4.Create Key Vault to store Azure storage key for the blob account access
az keyvault create --name "terraformblobkey" --resource-group "rg-experiments-sea" --location "EastUS" </br>
az keyvault secret set --vault-name "terraformblobkey" --name "blobkey" --value "#StorageAccountKey#" </br>

The value from the key vault can be retrieved using AzCLI command and it gets exported to ARM_ACCESS_KEY environment variables, that will be utilized in Azure Remote Backend intialization </br>

export ARM_ACCESS_KEY=$(az keyvault secret show --name blobkey --vault-name terraformblobkey --query value -o tsv) </br>

## 5.Execute Terraform script in sequence
1. terraform init
2. terraform plan
3. terraform apply -var="key=value"

A good practice is to create seperate resource group for Azure Backend and your newly created resources </br>
If you wanted to import an existing resource use the below cmd </br>
terraform import azurerm_resource_group.resourcegroup /subscriptions/subscriptionid/resourceGroups/rg-experiments-apim</br>

## TF State file on Blob Storage
![Alt text](./BlobStorage.PNG?raw=true "Blob Storage")

