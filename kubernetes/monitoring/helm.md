# Monitoring using Helm

## Install Tiller

``` shell
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

## Prometheus operator

Maybe use prometheus-operator instead of prometheus and grafana. <https://www.digitalocean.com/community/tutorials/how-to-set-up-digitalocean-kubernetes-cluster-monitoring-with-helm-and-prometheus-operator#prerequisites>

```shell
helm install --namespace monitoring --name doks-cluster-monitoring -f custom-values.yaml stable/prometheus-operator
```

## Prometheus

``` shell
helm install --name prometheus stable/prometheus --namespace monitoring
```

## Grafana

``` shell
helm install --name grafana stable/grafana --namespace monitoring
```

* Dashboards JVM: 4701, 10280, 5373, 6083
* K8s: 6417, 315

* WARNING: Persistence is disabled!

## Logging

* Use EFK(elasticsearch, fluentd, kibana) with custom scrips in folder logging.

* TODO: find a solution to use Helm that uses minimal resources.
