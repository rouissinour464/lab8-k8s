#!/bin/bash

NAMESPACE=lab8

echo "🔹 Vérification des noms stables des pods..."
kubectl delete pod postgres-0 -n $NAMESPACE
kubectl get pods -n $NAMESPACE -l app=postgres

echo "🔹 Vérification des DNS stables..."
kubectl exec -it postgres-0 -n $NAMESPACE -- nslookup postgres-0.postgres-headless.$NAMESPACE.svc.cluster.local

echo "🔹 Test de persistance des données..."
kubectl exec -it postgres-0 -n $NAMESPACE -- psql -U $POSTGRES_USER -d $POSTGRES_DB -c "CREATE TABLE test_stateful(id INT PRIMARY KEY);"
kubectl delete pod postgres-0 -n $NAMESPACE
kubectl exec -it postgres-0 -n $NAMESPACE -- psql -U $POSTGRES_USER -d $POSTGRES_DB -c "\dt"

echo "🔹 Test du scaling du StatefulSet..."
kubectl scale statefulset postgres --replicas=3 -n $NAMESPACE
kubectl get pods -n $NAMESPACE -l app=postgres
kubectl get pvc -n $NAMESPACE
