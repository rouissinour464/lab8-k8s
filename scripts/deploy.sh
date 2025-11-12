#!/bin/bash

NAMESPACE=lab8

echo "🔹 Déploiement du namespace '$NAMESPACE'..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

echo "🔹 Déploiement ConfigMap..."
kubectl apply -f ../k8s/configmap-db.yaml -n $NAMESPACE

echo "🔹 Déploiement Secret..."
kubectl apply -f ../k8s/secret-db.yaml -n $NAMESPACE

echo "🔹 Déploiement Headless Service..."
kubectl apply -f ../k8s/postgres-headless-service.yaml -n $NAMESPACE

echo "🔹 Déploiement StatefulSet PostgreSQL..."
kubectl apply -f ../k8s/postgres-statefulset.yaml -n $NAMESPACE

echo "⏳ Attente que le StatefulSet soit prêt..."
kubectl rollout status statefulset/postgres -n $NAMESPACE

echo "🔹 Déploiement Service régulier PostgreSQL pour web app..."
kubectl apply -f ../k8s/postgres-service.yaml -n $NAMESPACE

echo "🔹 Déploiement web app..."
kubectl apply -f ../k8s/web-deployment.yaml -n $NAMESPACE
kubectl apply -f ../k8s/web-service.yaml -n $NAMESPACE

echo "🔹 Vérification finale des pods et PVC..."
kubectl get pods -n $NAMESPACE -l app=postgres
kubectl get pvc -n $NAMESPACE
kubectl get svc -n $NAMESPACE
