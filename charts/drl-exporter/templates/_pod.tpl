{{/*
Defines the PodSpec for exporter.
*/}}
{{- define "drl.pod" -}}
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
serviceAccountName: {{ include "drl.fullname" . }}
{{- end }}
containers:
  - name: drl-exporter
    image: "{{ .Values.image.repository }}/{{ .Values.image.name }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    ports:
    - name: http
      containerPort: {{ default "2121" .Values.exporter.listenPort }}
      protocol: TCP
{{- if .Values.command }}
    command: {{ .Values.command }}
{{- end }}
{{- if .Values.args }}
    args: {{ toYaml .Values.args | nindent 6 }}
{{- end }}
    env:
    - name: EXPORTER_PORT
      value: {{ default 2121 .Values.exporter.listenPort | quote }}
{{- if .Values.exporter.auth.enabled -}}
    - name: DOCKERHUB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: {{ include "drl.fullname" . }}-secrets
          key: dockerhub-password
    - name: DOCKERHUB_USER
      valueFrom:
        secretKeyRef:
          name: {{ include "drl.fullname" . }}-secrets
          key: dockerhub-username
{{- end }}
{{- if .Values.exporter.auth.enabled -}}
    - name: FILE_AUTH_DIR
      valueF: {{ default "/config" .Values.exporter.auth.enableFileAuth.configFileLocation | quote }}
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