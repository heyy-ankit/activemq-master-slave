# activemq-master-slave

Initial scaffold for building and deploying Apache ActiveMQ on Kubernetes with Helm.

## Included in this initial version

- Custom ActiveMQ container image build files:
  - `docker/Dockerfile`
  - `docker/entrypoint.sh`
- Helm chart with core Kubernetes resources:
  - `ConfigMap`
  - `Secret`
  - `Service`
  - `StatefulSet`

Chart location: `chart/activemq`

## Quick start

1. Build image:
   ```bash
   docker build -t activemq-custom:5.18.4 -f docker/Dockerfile .
   ```
2. Install chart:
   ```bash
   helm upgrade --install activemq ./chart/activemq --namespace messaging --create-namespace
   ```
3. Check pods:
   ```bash
   kubectl get pods -n messaging
   ```

See full instructions in [`chart/activemq/README.md`](chart/activemq/README.md).


## Troubleshooting

If pod logs show `/usr/bin/env: bash\r: No such file or directory`, rebuild the image with the updated Dockerfile and redeploy Helm release.
