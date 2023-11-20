# Helmchart for Gitea Act Runner

#### This chart can be used to deploy act runner for gitea as [Statefulset](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) or [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) in both rootless or root mode.

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.6](https://img.shields.io/badge/AppVersion-0.2.6-informational?style=flat-square)

## Installing the Chart

To install the chart with the release name `act-runner`

```console
$ helm repo add lmno http://charts.lmno.pk
$ helm install act-runner lmno/act-runner
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Configure [affinity and anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity). |
| args | list | `[]` | Override default image arguments. |
| command | list | `[]` | Override default image command. |
| dnsConfig | object | `{}` | Specify a custom dns config [dnsConfig](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-dns-config). |
| dnsPolicy | string | `"ClusterFirst"` | Specify dns policy [dnsPolicy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy). |
| env | list | `[{"name":"DOCKER_HOST","value":"tcp://localhost:2376"},{"name":"DOCKER_CERT_PATH","value":"/certs/client"},{"name":"DOCKER_TLS_VERIFY","value":"1"}]` | Define environment variables. |
| envFrom | list | `[]` | Define environment variables from existing ConfigMap or Secret data. |
| extraContainers | list | `[]` | Specify extra Containers to be added. |
| extraVolumeMounts | list | `[]` | Specify Additional VolumeMounts to use. |
| extraVolumes | list | `[]` | Specify additional Volumes to use. |
| global.commonLabels | object | `{}` | Apply labels to all resources. |
| global.fullnameOverride | string | `""` | Override the fully qualified app name. |
| global.nameOverride | string | `""` | Override the name of the app. |
| image.name | string | `"gitea/act_runner"` | Specify the image name to use (relative to `image.repository`). |
| image.pullPolicy | string | `"Always"` | Specify the [pullPolicy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy). |
| image.pullSecrets | list | `[]` | Specify the image pull secrets if pulling from private registry [imagePullSecrets](https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod). |
| image.repository | string | `"docker.io"` | Specify the image repository to use. |
| image.tag | string | `"nightly"` | Specify the image tag to use. ( nightly or nightly-dind-rootless ) |
| initContainers | list | `[]` | Specify initContainers to be added. |
| lifecycle | object | `{}` | Specify lifecycle hooks for Containers. |
| livenessProbe | object | `{}` | Specify the livenessProbe [configuration](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes). |
| nodeSelector | object | `{}` | Configure [nodeSelector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector). |
| persistence.accessModes | string | `"ReadWriteOnce"` | Specify the accessModes for PersistentVolumeClaims. |
| persistence.enabled | bool | `true` | If **true**, create and use PersistentVolumeClaims. |
| persistence.existingClaim | string | `""` | Name of an existing PersistentVolumeClaim to use. |
| persistence.mountPath | string | `"/data"` | Path inside the container where volume will be mounted |
| persistence.selector | object | `{}` | Specify the selectors for PersistentVolumeClaims. |
| persistence.size | string | `"1Gi"` | Specify the size of PersistentVolumeClaims. |
| persistence.storageClassName | string | `""` | Specify the storageClassName for PersistentVolumeClaims. |
| podAnnotations | object | `{}` | Set annotations on Pods. |
| podHostNetwork | bool | `false` | Enable the hostNetwork option on Pods. |
| podLabels | object | `{}` | Set labels on Pods. |
| podPriorityClassName | string | `""` | Set the [priorityClassName](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#priorityclass). |
| podSecurityContext | object | `{"fsGroup":1000}` | Allows you to overwrite the default. Only applied when using rootless container [PodSecurityContext](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/). |
| readinessProbe | object | `{}` | Specify the readinessProbe [configuration](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes). |
| replicas | string | `"1"` | only one replica as runner doesn't support clustering. default set to `1` |
| resources | object | `{}` | Specify resource requests and limits. |
| runner.config | object | `nil` | Specify runner's custom configuration |
| runner.config.data | string | `"log:\n  level: info\nrunner:\n  labels: []\n"` | Your custom config block |
| runner.config.enabled | bool | `false` | Enables configuration for deployment |
| runner.dockerDind | object | `{"enabled":"ture","image":"docker:23.0.6-dind"}` | @default `nil` |
| runner.dockerDind.enabled | string | `"ture"` | enable docker dind |
| runner.dockerDind.image | string | `"docker:23.0.6-dind"` | docker image repository |
| runner.instanceURL | string | `"http://gitea-http.apps.svc.cluster.local:3000"` | Gitea instance URL  |
| runner.runnerToken | object | `{"existingSecret":"","value":"< token here >"}` | Runner registration token |
| runner.runnerToken.existingSecret | string | `""` | Specify an existing secret containing runner token with key (token: value) |
| runner.runnerToken.value | string | `"< token here >"` | Set registration token value, if existing secret is specified this value is not used. |
| runner.updateStrategy | object | `{"type":"Recreate"}` | valid options for statefulset `RollingUpdate`, `OnDelete` / Deployment: `RollingUpdate`, `Recreate` |
| runner.useStatefulSet | bool | `false` | Set to true to use a StatefulSet instead of a Deployment |
| securityContext | object | `{"privileged":true}` | Specify securityContext for Containers. |
| terminationGracePeriodSeconds | int | `10` | Override terminationGracePeriodSeconds. |
| tolerations | list | `[]` | Configure [taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/). |
| topologySpreadConstraints | list | `[]` | Configure [topology spread constraints](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/). |

