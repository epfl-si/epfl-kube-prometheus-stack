## add repo
add-repo:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

## or update repo
update-repo:
	helm repo update

## create the default values file
show-values:
	helm show values prometheus-community/kube-prometheus-stack > kube-prometheus-stack-epfl.yml

## dry-run the install
dry-run:
	helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --create-namespace --namespace monitoring --dry-run --debug

## real install
install:
# helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack
	helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --create-namespace --namespace monitoring --debug

## upgrade
upgrade:
	helm upgrade epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --debug

## uninstall
uninstall:
	helm uninstall epfl-kube-prometheus-stack


## Port Forwarding
pf-grafana:
	kubectl port-forward --namespace monitoring svc/epfl-kube-prometheus-stack-grafana 1337:80

pf-prometheus:
	kubectl port-forward --namespace monitoring svc/epfl-kube-prometheus-stack-prometheus 9090:9090


## info
info:
	kubectl cluster-info
context:
	kubectl config get-contexts

## diff
diff:
	diff --color kube-prometheus-stack-epfl.yml kube-prometheus-stack-default.yml
