# ActiveMQ Helm chart (initial version)

This chart deploys a single-replica Apache ActiveMQ **StatefulSet** with:

- `ConfigMap` for `activemq.xml`
- `Secret` for admin credentials
- `Service` for OpenWire (61616) and Web Console (8161)
- `PersistentVolumeClaim` for broker data

## Prerequisites

- Kubernetes cluster (Rancher Desktop is fine)
- Helm 3+
- A locally built/pushed ActiveMQ image

## Build the image

From repository root:

```bash
docker build -t activemq-custom:5.18.4 -f docker/Dockerfile .
```

For Rancher Desktop (`nerdctl`):

```bash
nerdctl build -t activemq-custom:5.18.4 -f docker/Dockerfile .
```

## Install chart

```bash
helm upgrade --install activemq ./chart/activemq \
  --namespace messaging \
  --create-namespace \
  --set image.repository=activemq-custom \
  --set image.tag=5.18.4 \
  --set security.adminUsername=admin \
  --set security.adminPassword='StrongPasswordHere'
```

## Verify

```bash
kubectl get pods -n messaging
kubectl get svc -n messaging
kubectl get pvc -n messaging
```

## Access Web Console

```bash
kubectl port-forward -n messaging svc/activemq 8161:8161
```

Then open `http://localhost:8161`.
