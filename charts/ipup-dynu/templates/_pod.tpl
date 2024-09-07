{{/*
Defines the PodSpec for ipup-dynu.
*/}}
{{- define "ipup.pod" -}}
{{- if .Values.podHostNetwork }}
hostNetwork: {{ .Values.podHostNetwork }}
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
{{- if .Values.serviceAccount.create }}
serviceAccountName: {{ include "ipup.fullname" . }}
{{- end }}
containers:
  - name: ipup-dynu
    image: "{{ .Values.image.repository }}/{{ .Values.image.name }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
{{- if .Values.command }}
    command: {{ .Values.command }}
{{- end }}
{{- if .Values.args }}
    args: {{ toYaml .Values.args | nindent 6 }}
{{- end }}
    env:
    - name: DYNU_DOMAIN_NAME
      value: {{ default "example.com" .Values.ipup.config.domainName | quote }}
    - name: DYNU_IPCHECK_INTERVAL
      value: {{ default 60 .Values.ipup.config.requestInterval | quote }}
{{- if .Values.ipup.config.dynuGroup.enabled }}
    - name: DYNU_ENABLE_GROUP
      value: "true"
    - name: DYNU_GROUP_NAME
      value: {{ default "" .Values.ipup.config.dynuGroup.groupName | quote }}
{{- end }}
    - name: DYNU_PASSWORD
      valueFrom:
        secretKeyRef:
          name: {{ include "ipup.fullname" . }}-secrets
          key: dynu-password
    - name: DYNU_USERNAME
      valueFrom:
        secretKeyRef:
          name: {{ include "ipup.fullname" . }}-secrets
          key: dynu-username
    - name: LOG_LEVEL
      value: {{ default "info" .Values.ipup.config.logs.level | quote }}
    - name: ENABLE_LOG_SOURCE
      value: {{ default "false" .Values.ipup.config.logs.enableSource | quote }}
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
{{- end }}