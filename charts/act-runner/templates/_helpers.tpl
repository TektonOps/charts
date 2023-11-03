{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ar.name" -}}
{{- default .Chart.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate strings at 63 characters because some Kubernetes name fields are limited to this (by the DNS naming spec).
If the release name contains a chart name it will be used as a full name.
*/}}
{{- define "ar.fullname" -}}
{{- if .Values.global.fullnameOverride }}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.global.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ar.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common template labels.
*/}}
{{- define "ar.template-labels" -}}
app.kubernetes.io/name: {{ include "ar.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "ar.labels" -}}
helm.sh/chart: {{ include "ar.chart" . }}
{{ include "ar.template-labels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
{{- end }}
{{- if .Values.global.commonLabels }}
{{ toYaml .Values.global.commonLabels }}
{{- end }}
{{- end -}}

{{/*
Return the ServiceAccount name
*/}}
{{- define "ar.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- template "ar.fullname" . }}
{{- else }}
{{- .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the target Kubernetes version
*/}}
{{- define "ar.kubeVersion" -}}
    {{- .Capabilities.KubeVersion.Version -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "ar.deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "ar.kubeVersion" .) -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for statefulset.
*/}}
{{- define "ar.statefulset.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "ar.kubeVersion" .) -}}
{{- print "apps/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}


