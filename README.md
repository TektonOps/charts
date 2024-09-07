# Helm Charts


## Usage

1. Add this helm chart repo to your helm client configuration

    ```
    helm repo add tektonops https://charts.tektonops.com
    helm repo update

    ```
2. Update repo and search

    ```
    helm search repo -l tektonops

    ```
3. Install the chart

    ```
    helm install act-runner tektonops/act-runner
    ```

4. Uninstall
    ```
    helm uninstall act-runner
    ```
