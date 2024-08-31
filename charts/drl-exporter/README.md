# Rate Limit Exporter

### This chart can be used to deploy  [DRL Exporter](https://github.com/kha7iq/drl-exporter).

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.1.3](https://img.shields.io/badge/AppVersion-2.1.3-informational?style=flat-square)

## Installing the Chart

To install the chart with the release name `drl-exporter`

```console
$ helm repo add lmno http://charts.lmno.pk
$ helm install drl-exporter lmno/drl-exporter
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure [affinity and anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| args | list | `[]` | Override default image arguments. |
| command | list | `[]` | Override default image command. |
| dnsConfig | object | `{}` | Specify a custom dns config [dnsConfig](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config). |
| dnsPolicy | string | `"ClusterFirst"` | Specify dns policy [dnsPolicy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy). |
| env | list | `[]` | Define environment variables. |
| envFrom | list | `[]` | Define environment variables from existing ConfigMap or Secret data. |
| exporter.auth.dockerHubPassword | string | `""` | Dockerhub passowrd |
| exporter.auth.dockerHubUsername | string | `""` | Dockerhub username |
| exporter.auth.enableFileAuth | object | `{"configFileLocation":"","enabled":false}` | Docker config file based authentication |
| exporter.auth.enableFileAuth.configFileLocation | string | `""` | Config file location  |
| exporter.auth.enableFileAuth.enabled | bool | `false` | Enable file based authentication |
| exporter.auth.enabled | bool | `false` | Enable/disable authentication for given account |
| exporter.listenPort | int | `2121` |  |
| exporter.requestInterval | string | `"15"` | Specify the interval in seconds at which requests should be sent to Dockerhub |
| global.commonLabels | object | `{}` | Apply labels to all resources. |
| global.fullnameOverride | string | `""` | Override the fully qualified app name. |
| global.nameOverride | string | `""` | Override the name of the app. |
| image.name | string | `"khaliq/drl-exporter"` | Specify the image name to use (relative to `image.repository`). |
| image.pullPolicy | string | `"Always"` | Specify the [pullPolicy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| image.pullSecrets | list | `[]` | Specify the image pull secrets if pulling from private registry [imagePullSecrets](https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod). |
| image.repository | string | `"docker.io"` | Specify the image repository to use. |
| image.tag | string | `"latest"` | Specify the image tag to use. ( latest or specific release ) |
| lifecycle | object | `{}` | Specify lifecycle hooks for Containers. |
| livenessProbe | object | `{}` | Specify the livenessProbe [configuration](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes). |
| nodeSelector | object | `{}` | Configure [nodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| podAnnotations | object | `{}` | Set annotations on Pods. |
| podHostNetwork | bool | `false` | Enable the hostNetwork option on Pods. |
| podLabels | object | `{}` | Set labels on Pods. |
| podPriorityClassName | string | `""` | Set the [priorityClassName](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#priorityclass). |
| readinessProbe | object | `{}` | Specify the readinessProbe [configuration](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes). |
| resources | object | `{"limits":{"cpu":"500m","memory":"256Mi"},"requests":{"cpu":"100m","memory":"128Mi"}}` | Specify resource requests and limits. |
| serviceAccount.create | bool | `true` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `"1m"` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.relabelings | list | `[]` |  |
| serviceMonitor.scheme | string | `"http"` |  |
| serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| serviceMonitor.tlsConfig | object | `{}` |  |
| tolerations | list | `[]` | Configure [taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| topologySpreadConstraints | list | `[]` | Configure [topology spread constraints](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/). |

