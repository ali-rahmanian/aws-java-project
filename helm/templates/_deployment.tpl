{{- define "deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: {{ .name }}-webapp
  name: {{ .name }}-dep
spec:
  replicas: {{ .replicas }}
  selector:
    matchLabels:
      app: {{ .name }}-webapp
  template:
    metadata:
      labels:
        app: {{ .name }}-webapp
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 50
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - {{ .name }}-webapp
              topologyKey: topology.kubernetes.io/zone  
          - weight: 50
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - {{ .name }}-webapp
              topologyKey: kubernetes.io/hostname  
      containers:
      - name: {{ .name }}-pod
        image: {{ .imageName | default "myService" }}:{{ .imageTag | default "1.0.0" }}{{ if .development }}-dev{{end}}
        imagePullPolicy: Always
        resources:
          limits:
            cpu: {{ .cpuLimit }}
          requests:
            cpu: {{ .cpuRequest }}
        ports:
        - containerPort: {{ .internalLb.targetPort | default 80 }}
        readinessProbe:
          httpGet:
            path: /
            port: {{ .internalLb.targetPort | default 80 }}
          initialDelaySeconds: 5
          periodSeconds: 30
          timeoutSeconds: 10
          successThreshold: 1
          failureThreshold: 3
---
{{- end -}}