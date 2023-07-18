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
	# kubectl kustomize workloads/kafka-broker-2/ | kubectl apply -f -
	# kubectl wait kafka/kafka-broker-2 --for=condition=Ready --timeout=300s -n kafka

provision-mm2:
	kubectl kustomize workloads/kafka-mirrormaker | kubectl apply -f -
	kubectl wait deployment/kafka-mirror-mirrormaker2 --for=condition=Available --timeout=300s -n kafka

teardown-kafka:
	kubectl delete kafka kafka-broker-1 -n kafka
	kubectl delete deployment strimzi-cluster-operator
	kubectl delete deployment kafka-broker-1-entity-operator
	kubectl delete kafkamirrormaker2 kafka-mirror

kafka-topics:
	kubectl run --rm -i --tty kafka-shell --image=confluentinc/cp-kafka:latest -- /bin/kafka-topics --bootstrap-server 10.97.99.17:9092 --list

kafka-consumer-groups:
	kubectl run --rm -i --tty kafka-shell --image=confluentinc/cp-kafka:latest -- /bin/kafka-consumer-groups --bootstrap-server 10.97.99.17:9092 --list
