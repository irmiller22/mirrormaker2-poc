down:
	minikube stop

up:
	minikube start --memory=6144 --cpus=4 --driver=docker
	minikube addons enable metrics-server

provision-kafka:
	kubectl kustomize workloads/kafka-operator/ | kubectl apply -f -
	kubectl wait deployment/strimzi-cluster-operator --for=condition=Available --timeout=300s -n kafka
	kubectl kustomize workloads/kafka-broker-1/ | kubectl apply -f -
	kubectl wait kafka/kafka-broker-1 --for=condition=Ready --timeout=300s -n kafka
	kubectl kustomize workloads/kafka-broker-2/ | kubectl apply -f -
	kubectl wait kafka/kafka-broker-2 --for=condition=Ready --timeout=300s -n kafka

