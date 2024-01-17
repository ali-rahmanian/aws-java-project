{{- define "internalService" -}}
apiVersion: v1
kind: Service
metadata: 
  name: internal-{{ .name }}-service
  annotations:
     service.beta.kubernetes.io/aws-load-balancer-internal: 0.0.0.0/0
     service.beta.kubernetes.io/aws-load-balancer-type: nlb
     service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: 'true'
spec:
  selector:
    app: {{ .name }}-webapp
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: {{ .internalLb.port | default 80 }}
      targetPort: {{ .internalLb.targetPort | default 80 }}
---
{{- end -}}