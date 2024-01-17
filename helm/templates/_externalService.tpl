{{- define "externalService" -}}
apiVersion: v1
kind: Service
metadata: 
  name: external-{{ .name }}-service
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
    service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: 'true'
spec:
  selector:
    app: {{ .name }}-webapp
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: {{ .externalLb.port | default 80 }}
      targetPort: {{ .externalLb.targetPort | default 80 }}
---
{{- end -}}