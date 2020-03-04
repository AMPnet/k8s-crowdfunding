# Kubernetes

## Docker registry

Use command to create docker-registry credentials:

``` shell
kubectl create secret docker-registry myregistrykey \
  --docker-server=$DOCKER_REGISTRY_SERVER \
  --docker-username=$DOCKER_USER \
  --docker-password=$DOCKER_PASSWORD \
  --docker-email=$DOCKER_EMAIL
```

## Configuration

* Resource Quotas: you can (and should) restrict the resource usage of a given namespace.
* LimitRange: Use LimitRanges in each namespace to set default resource requests and limits for containers, but don’t rely on them; treat them as a backstop. Always specify explicit requests and limits in the container spec itself.
* ConfigMap: <https://github.com/spring-cloud/spring-cloud-kubernetes#5-kubernetes-propertysource-implementations>

### Security

* Run containers as non-root users, and block root containers from running, using the `runAsNonRoot: true` setting.
* It’s good practice to always set readOnlyRootFilesystem unless the container really does need to write to files.
* These settings will apply to all containers in the Pod, unless the container overrides a given setting in its own security context:

``` yaml
apiVersion: v1
kind: Pod
...
spec:
      securityContext:
        runAsUser: 1000
        runAsNonRoot: true
        allowPrivilegeEscalation: false
```

### Logging

* Use fluentd.
* Paid services: Splunk and Loggly

## Ingress

* Explanation: <https://blog.getambassador.io/kubernetes-ingress-nodeport-load-balancers-and-ingress-controllers-6e29f1c44f2d>
* Ingress must have Ingress controller - e.g. Nginx, Treafik
* Use Ingress to expose services to outside internet. <https://auth0.com/blog/kubernetes-tutorial-step-by-step-introduction-to-basic-concepts/>
* Change service spec type from NodePort to ClusterIP - "I don’t recommend using this method in production to directly expose your service." <https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0>
* Helm Nginx: <https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-on-digitalocean-kubernetes-using-helm#step-2-%E2%80%94-installing-the-kubernetes-nginx-ingress-controller>
* Monitor Nginx using Prometheus
* Alternative for Nginx: Traefik as ingress Controller: <https://traefik.io/>
* Setup TLS <https://docs.cert-manager.io/en/latest/tutorials/acme/quick-start/>
* TLS existing certificate:

``` yaml
spec:
      tls:
      - secretName: demo-tls-secret
```

## TODO

* Remove `type: NodePort` in all services!
* Set specific version for docker images. In all deployments change `imagePullPolicy` value to `IfNotPresent`.
* Add namespaces!
* Use Prometheus Alertmanager <https://prometheus.io/docs/alerting/alertmanager/>

### Nice to have

* Kubernetes validation: `kubeval *.yaml`. It’s a good idea to add kubeval to your continuous deployment pipeline, so that mani‐ fests are automatically validated whenever you make changes to them.
* Horizontal Pod Autoscaler: <https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/>
* Autoscaler: <https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler>
* Resource management: <https://jaxenter.com/manage-container-resource-kubernetes-141977.html>
* Observe: <https://github.com/pulumi/kubespy>
* Workload balance: <https://github.com/kubernetes-incubator/descheduler>
* Run Sonobuoy once your cluster is set up for the first time, to ver‐ ify that it’s standards-compliant and that everything works. <https://github.com/heptio/sonobuoy>
* Auditing tools: <https://k8guard.github.io/about/> or <https://github.com/aquasecurity/kube-bench>
* Chaos testing
* Debugging: <https://github.com/solo-io/squash>
* Add RBAC. The predefined roles cluster-admin, edit, and view will probably cover most requirements.
* Helm release with failure rollback: <https://blog.container-solutions.com/automated-rollback-helm-releases-based-logs-metrics>
* Tracing: Zipkin, Jaeger, and LightStep. Info: <https://medium.com/@masroor.hasan/tracing-infrastructure-with-jaeger-on-kubernetes-6800132a677> <https://opentracing.io/>
* Monitoring services: Uptime Robot, Pingdom, and Wormly.
* CI/CD: <https://github.com/fluxcd/flux>, <https://github.com/keel-hq/keel>, <https://drone.io/>, <https://codefresh.io/>, <https://gitkube.sh/>
