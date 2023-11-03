{{/*
Defines the PodSpec for runnerer Server.
*/}}
{{- define "ar.pod" -}}
{{- if .Values.podHostNetwork }}
hostNetwork: {{ .Values.podHostNetwork }}
{{- end }}
{{- if and .Values.podSecurityContext (not .Values.runner.dockerDind.enabled) }}
securityContext: {{ toYaml .Values.podSecurityContext | nindent 2 }}
{{- end }}
{{- if .Values.podPriorityClassName }}
priorityClassName: {{ .Values.podPriorityClassName }}
{{- end }}
{{- if .Values.dnsPolicy }}
dnsPolicy: {{ .Values.dnsPolicy }}
{{- end }}
{{- if .Values.dnsConfig }}
dnsConfig: {{ toYaml .Values.dnsConfig | nindent 2 }}
{{- end }}
{{- if .Values.image.pullSecrets }}
imagePullSecrets: {{ toYaml .Values.image.pullSecrets | nindent 2 }}
{{- end }}
{{- if .Values.initContainers }}
initContainers: {{ toYaml .Values.initContainers | nindent 2 }}
{{- end }}
containers:
{{- if .Values.runner.dockerDind.enabled }}
  - name: docker-daemon
{{- if .Values.securityContext }}
    securityContext: {{ toYaml .Values.securityContext | nindent 6 }}
{{- end }}
    image: {{ .Values.runner.dockerDind.image | quote }}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    env:
    - name: DOCKER_TLS_CERTDIR
      value: "/certs"
    volumeMounts:
      - name: docker-certs
        mountPath: "/certs"
{{- end }}
  - name: act-runner
{{- if .Values.securityContext }}
    securityContext: {{ toYaml .Values.securityContext | nindent 6 }}
{{- end }}
    image: "{{ .Values.image.repository }}/{{ .Values.image.name }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
{{- if .Values.command }}
    command: {{ .Values.command }}
{{- end }}
{{- if .Values.args }}
    args: {{ toYaml .Values.args | nindent 6 }}
{{- end }}
    env:
    - name: GITEA_INSTANCE_URL
      value: {{ .Values.runner.instanceURL }}
    - name: GITEA_RUNNER_REGISTRATION_TOKEN
      valueFrom:
        secretKeyRef:
          name: {{ include "ar.fullname" . }}-secrets
          key: token
{{- if .Values.runner.config.enabled }}
    - name: CONFIG_FILE
      value: "/conf/config.yaml"
{{- end }}
{{- if .Values.env }}
{{ toYaml .Values.env | indent 4 }}
{{- end }}
{{- if .Values.envFrom }}
    envFrom: {{ toYaml .Values.envFrom | nindent 6 }}
{{- end }}
{{- if .Values.livenessProbe }}
    livenessProbe: {{ toYaml .Values.livenessProbe | trim | nindent 6 }}
{{- end }}
{{- if .Values.readinessProbe }}
    readinessProbe: {{ toYaml .Values.readinessProbe | trim | nindent 6 }}
{{- end }}
{{- if .Values.resources }}
    resources: {{ toYaml .Values.resources | nindent 6 }}
{{- end }}
{{- if .Values.lifecycle }}
    lifecycle: {{ toYaml .Values.lifecycle | nindent 6 }}
{{- end }}
    volumeMounts:
      - name: data
        mountPath: "{{ .Values.persistence.mountPath | default "/data" }}"
{{- if .Values.runner.config.enabled }}
      - name: config
        mountPath: "/conf"
{{- end }}
{{- if .Values.runner.dockerDind.enabled }}
      - name: docker-certs
        mountPath: "/certs"
{{- end }}
{{- if .Values.extraVolumeMounts }}
{{ toYaml .Values.extraVolumeMounts | indent 6 }}
{{- end }}
{{- if .Values.extraContainers }}
{{ toYaml .Values.extraContainers | indent 2 }}
{{- end }}
terminationGracePeriodSeconds: {{ .Values.terminationGracePeriodSeconds }}
{{- if .Values.nodeSelector }}
nodeSelector: {{ toYaml .Values.nodeSelector | nindent 2 }}
{{- end }}
{{- if .Values.affinity }}
affinity: {{ toYaml .Values.affinity | nindent 2 }}
{{- end }}
{{- if .Values.tolerations }}
tolerations: {{ toYaml .Values.tolerations | nindent 2 }}
{{- end }}
{{- if  .Values.topologySpreadConstraints }}
topologySpreadConstraints: {{ toYaml .Values.topologySpreadConstraints | nindent 2 }}
{{- end }}
volumes:
{{- if .Values.persistence.enabled }}
{{- if .Values.persistence.existingClaim }}
  - name: data
    persistentVolumeClaim:
      claimName: {{ .Values.persistence.existingClaim }}
{{- end }}
{{- end }}
{{- if .Values.extraVolumes }}
{{ toYaml .Values.extraVolumes | indent 2 }}
{{- end }}
{{- end }}