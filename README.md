# kube-prometheus-stack-epfl

Le but de ce repository est de tester le déploiement, avec [Helm], de la
stack [kube-prometheus-stack] sur un namespace `monitoring` de l'un de nos
clusters [Kubernetes]. Son objectif est de pouvoir proposer, as a service, une
configuration prête à l'emploi (sous-entendu un fichier `values.yaml` testé et
approuvé) de la stack [Prometheus] pouvant être déployée sur nos clusters.


## Qu'est-ce que la stack kube-prometheus ?

La stack kube-prometheus ([kube-prometheus-stack]) est une collection de
manifestes Kubernetes, de tableaux de bord Grafana et de règles Prometheus (y
compris des alertes) permettant de déployer le monitoring ([Prometheus] & co)
dans un cluster. L'opérateur Prometheus ([prometheus-operator]) est utilisé pour
déployer et manager les composants de la stack au sein du cluster.

Il est important de comprendre que [kube-prometheus-stack] est le chart Helm de
[prometheus-stack] qui inclus les composants suivants :
* The [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator)
* Highly available [Prometheus](https://prometheus.io/)
* Highly available [Alertmanager](https://github.com/prometheus/alertmanager)
* [Prometheus node-exporter](https://github.com/prometheus/node_exporter)
* [Prometheus Adapter for Kubernetes Metrics APIs](https://github.com/DirectXMan12/k8s-prometheus-adapter)
* [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics)
* [Grafana](https://grafana.com/)


## Comment utiliser ce dépôt

Les commandes de bases sont listées dans le [Makefile](./Makefile). Il est
forcément nécessaire d'avoir accès à un cluster (par exemple une commande qui
commence par `tkgi get-kubeconfig...`) et d'avoir [Helm] installé.

| ⚠️ Helm opère dans le contexte courrant. Les commandes `kubectl cluster-info` et/ou `kubectl config get-contexts` permettent de valider la cible et évitent des déploiements involontaires... ⚠️ |
| :---: |


1. Pour commencer, on veille à installer le repo Helm de prometheus-community :  
  `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
1. On récupère le fichier de values :  
  `helm show values prometheus-community/kube-prometheus-stack > kube-prometheus-stack-default.yml`
1. La commande suivante permet d'analyser le manifest généré par Helm (50k lignes) :  
  `helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --dry-run --debug`
1. L'installation (ou le déploiement) est faite de la manière suivante :  
  `helm install epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --debug`
1. La modification est faites avec la commande `upgrade` :  
  `helm upgrade epfl-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-epfl.yml --debug`
1. Et pour finir la désinstallation avec :  
  `helm uninstall epfl-kube-prometheus-stack`

Notez que pour ce dernier point le chart Helm installe beaucoup
d'objets Kubernetes et que `helm uninstall` ne supprime pas toutes
les traces de son passage. Par exemple, les CRD sont laissées. Lisez
https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#uninstall-helm-chart
et https://github.com/prometheus-operator/prometheus-operator#removal pour plus
d'information sur la suppression.

Certaines erreurs, comme par exemple celles de [Gatekeeper], ne sont pas
toujours lisible dans Helm. L'utilistion d'un outil tel que [Lens] est
recommandée.


[Gatekeeper]: https://open-policy-agent.github.io/gatekeeper/
[Helm]: https://helm.sh/
[kube-prometheus-stack]: https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
[Kubernetes]: https://kubernetes.io/
[Lens]: https://k8slens.dev/
[prometheus-operator]: https://github.com/prometheus-operator/prometheus-operator
[prometheus-stack]: https://github.com/prometheus-operator/kube-prometheus
[prometheus]: https://prometheus.io/
