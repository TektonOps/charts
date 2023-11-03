# Helm Charts


## Usage

1. Add this helm chart repo to your helm client configuration

    ```
    helm repo add lmno https://charts.lmno.pk
    helm repo update

    ```
2. Update repo and search

    ```
    helm search repo -l lmno

    ```
3. Install the chart

    ```
    helm install act-runner lmno/act-runner
    ```

4. Uninstall
    ```
    helm uninstall act-runner
    ```
