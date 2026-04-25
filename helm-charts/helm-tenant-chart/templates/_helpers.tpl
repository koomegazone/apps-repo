{{/*
Chart name.
*/}}
{{- define "helm-tenant-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Fullname: tenantId-chartName.
*/}}
{{- define "helm-tenant-chart.fullname" -}}
{{- if .Values.tenantId }}
{{- printf "%s-%s" .Values.tenantId (include "helm-tenant-chart.name" .) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- include "helm-tenant-chart.name" . }}
{{- end }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "helm-tenant-chart.labels" -}}
helm.sh/chart: {{ include "helm-tenant-chart.name" . }}
{{ include "helm-tenant-chart.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "helm-tenant-chart.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.tenantId }}
tenant: {{ .Values.tenantId }}
{{- end }}
{{- end }}
