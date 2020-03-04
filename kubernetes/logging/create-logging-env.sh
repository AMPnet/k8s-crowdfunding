kubectl create -f kube-logging.yaml
kubectl create -f elasticsearch_statefulset.yaml
kubectl create -f elasticsearch_svc.yaml
kubectl create -f kibana.yaml
kubectl create -f fluentd.yaml
echo "kubectl port-forward svc/kibana 5601:5601 --namespace=kube-logging"
