# Terraform-K8S-Flask

Ce projet déploie une application Flask sur un cluster Kubernetes en utilisant Terraform.

## Prérequis

- Docker installé
- Azure CLI installé
- Terraform installé
- kubectl installé

## Étapes

1. **Connexion à Azure**

    Connectez-vous à votre compte Azure avec la commande suivante :

    ```bash
    az login
    ```

2. **Initialisation de Terraform**

    Naviguez vers le répertoire terraform et initialisez votre configuration Terraform :

    ```bash
    cd terraform && terraform init
    ```

3. **Planification de l'infrastructure**

    Exécutez la commande de planification de Terraform :

    ```bash
    terraform plan
    ```

    Confirmez le plan en tapant `yes`.

4. **Déploiement de l'infrastructure**

    Appliquez votre configuration Terraform :

    ```bash
    terraform apply
    ```

5. **Connexion au Azure Container Registry (ACR)**

    Remplacez `<acr-name>` par le nom de votre Azure Container Registry et connectez-vous :

    ```bash
    az acr login --name <acr-name>
    ```

6. **Construction et Push de l'image Docker**

    Remplacez `flaskregistryesgids5iw3` par le nom de votre registre de conteneurs si besoin.

    Pour l'architecture amd64 :

    ```bash
    docker build -t flaskregistryesgids5iw3.azurecr.io/flask-app:latest .
    docker push flaskregistryesgids5iw3.azurecr.io/flask-app:latest
    ```

    Pour l'architecture arm64 :

    ```bash
    docker buildx build --platform linux/arm64 -t flaskregistryesgids5iw3.azurecr.io/flask-app:latest --push .
    ```

7. **Connexion au Azure Kubernetes Service (AKS)**

    Remplacez `<cluster name>` et `<resource group name>` par le nom de votre cluster AKS et le nom de votre groupe de ressources :

    ```bash
    az aks get-credentials --overwrite-existing -n <cluster name> -g <resource group name>
    ```

8. **Déploiement de l'application**

    Appliquez le déploiement Kubernetes :

    ```bash
    kubectl apply -f kubernetes/deployment.yaml
    ```

9. **Vérification du déploiement**

    Obtenez l'IP publique du load balancer :

    ```bash
    terraform output public_ip
    ```

    Vous pouvez également obtenir l'IP publique depuis le portail Azure.

    Testez l'application en ouvrant votre navigateur et en naviguant vers `http://<external ip>`, ou utilisez curl :

    ```bash
    curl http://<external ip>
    ```

10. **Nettoyage**

    Lorsque vous avez terminé, vous pouvez supprimer les ressources que vous avez créées avec les commandes suivantes :

    Pour supprimer l'infrastructure Terraform :

    ```bash
    cd terraform && terraform destroy
    ```

    Confirmez la destruction en tapant `yes`.

    Pour vous déconnecter de Azure :

    ```bash
    az logout
    ```
