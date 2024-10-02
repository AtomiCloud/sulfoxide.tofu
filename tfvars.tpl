{{- $secrets := secret "32992bde-d1bc-46b3-88ae-5b3279943ae6" "arceus" "/" -}}
{{- range $secrets -}}
{{- if eq .Key "INFISICAL_CLIENT_ID" }}
infisical_client_id = "{{ .Value }}"
{{- end }}
{{- if eq .Key "INFISICAL_CLIENT_SECRET" }}
infisical_client_secret = "{{ .Value }}"
{{- end }}
{{- if eq .Key "TOFU_BACKEND" }}
tofu_backend = "{{ .Value }}"
{{- end }}
{{- end }}
