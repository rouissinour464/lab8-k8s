#!/bin/bash
# =====================================
# Script: deploy_k8s.sh
# Description: Déploie la base PostgreSQL et l’application Flask sur K3s
# =====================================

echo "🚀 Déploiement des ressources Kubernetes..."

cd ../k8s || exit

kubectl apply -f db-deployment.yaml
kubectl apply -f db-service.yaml
kubectl apply -f web-deployment.yaml
kubectl apply -f web-service.yaml

echo "✅ Ressources déployées avec succès !"
kubectl get pods
kubectl get svc
