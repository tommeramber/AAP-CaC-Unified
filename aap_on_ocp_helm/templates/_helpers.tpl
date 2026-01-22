{{- define "DBSecrets.Generator" -}}
{{ $root := index . 0 }}
{{- range (index $root.Values "secrets") }}
apiVersion: v1
kind: Secret
metadata:
  name: extenral-postgresql-configuration-{{ .db }}
  namespace: {{ $root.Values.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
data:
  host: {{ $root.Values.host | b64enc }} 
  port: {{ $root.Values.port | b64enc }}
  database: {{ .db | b64enc }}
  username: {{ $root.Values.username | b64enc }}
  password: {{ $root.Values.password | b64enc }}
  sslmode: {{ $root.Values.sslmode | b64enc }}
  type: {{ $root.Values.type| b64enc }}
type: Opaque
---
{{- end }}
{{- end }}
