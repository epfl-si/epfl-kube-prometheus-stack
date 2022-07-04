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
	helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --dry-run --debug

## real install
install:
# helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack
	helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --debug

## upgrade
upgrade:
	helm upgrade epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --debug

## uninstall
uninstall:
	helm uninstall epfl-kube-prometheus-stack
