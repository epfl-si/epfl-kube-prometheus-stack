## add repo
.PHONY: add-repo
add-repo:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

## or update repo
.PHONY: update-repo
update-repo:
	helm repo update

## create the default values file
show-values: kube-prometheus-stack-default.yml
	helm show values prometheus-community/kube-prometheus-stack > kube-prometheus-stack-default.yml

## dry-run the install
.PHONY: dry-run
dry-run:
	helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --create-namespace --namespace monitoring --dry-run --debug

## real install
.PHONY: install
install:
# helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack
	helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --create-namespace --namespace monitoring --debug

## upgrade
.PHONY: upgrade
upgrade:
	helm upgrade epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --namespace monitoring --debug

## uninstall
.PHONY: uninstall
uninstall:
	helm uninstall epfl-kube-prometheus-stack --namespace monitoring


## Port Forwarding
.PHONY: pf-grafana
pf-grafana:
	kubectl port-forward --namespace monitoring svc/epfl-kube-prometheus-stack-grafana 1337:80

.PHONY: pf-prometheus
pf-prometheus:
	kubectl port-forward --namespace monitoring svc/epfl-kube-prometheus-stack-prometheus 9090:9090


## info
.PHONY: info
info:
	kubectl cluster-info
.PHONY: context
context:
	kubectl config get-contexts

## diff
.PHONY: diff
diff:
	diff --color kube-prometheus-stack-epfl.yml kube-prometheus-stack-default.yml
