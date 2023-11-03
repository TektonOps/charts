# Helm Charts


## Usage

1. Add this helm chart repo to your helm client configuration

    ```
    helm repo add lmno https://charts.lmno.pk
    

    ```
2. Update repo and search

    ```
    helm repo update
    helm search repo -l lmno

    ```
3. Install the chart

    ```
    helm install act-runner lmno/act-runner --set runner.runnerToken.value=<runner registration tokent>
    ```

4. Uninstall
    ```
    helm uninstall act-runner
    ```
