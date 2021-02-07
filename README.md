# Blog Impressions Microservice Architecture on Kubernetes

This example application has the goal to show how to use kubernetes to implement
a microservice architecture.
MySQL, Redis and Kafka are made available as services in the cluster and are used
from the applications to store data and communicate between applications

## Setup

First of all start local kubernetes

```
$ minikube start
```

MySQL, Redis and Kafka are deployed using helm:

```
$ helm repo add t3n https://storage.googleapis.com/t3n-helm-charts
$ helm install mysql t3n/mysql --version 1.0.0

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install redis bitnami/redis --set usePassword=false

$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install kafka --set replicaCount=1 bitnami/kafka
```

To start the impressions service apply the impressions k8 configuration files

```
$ kubectl apply -f k8/impressions/impressions-configmap.yml
$ kubectl apply -f k8/impressions/impressions-deployment.yml
$ kubectl apply -f k8/impressions/impressions-service.yml
```

To start the blog application apply the blog k8 configuration files

```
$ kubectl apply -f k8/blog/blog-configmap.yml
$ kubectl apply -f k8/blog/blog-deployment.yml
$ kubectl apply -f k8/blog/blog-service.yml
```

And finally get the external-ip address by running

```
minikube tunnel
```
