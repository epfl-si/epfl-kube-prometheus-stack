# bitnami/kube-prometheus

https://github.com/bitnami/charts/tree/master/bitnami/kube-prometheus

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami

$ helm show values bitnami/kube-prometheus > bitnami-kube-prometheus-default.yml

$ helm install epfl-bitnami-kube-prometheus bitnami/kube-prometheus -f bitnami-kube-prometheus-epfl.yml --dry-run --debug

$ helm install epfl-bitnami-kube-prometheus bitnami/kube-prometheus -f bitnami-kube-prometheus-epfl.yml --debug

$ helm upgrade epfl-bitnami-kube-prometheus bitnami/kube-prometheus -f bitnami-kube-prometheus-epfl.yml --debug

$ helm uninstall epfl-bitnami-kube-prometheus
```
