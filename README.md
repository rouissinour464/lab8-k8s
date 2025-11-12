# Lab 6 – StatefulSet PostgreSQL

Ce laboratoire illustre le déploiement d'une base de données PostgreSQL avec un **StatefulSet** dans Kubernetes et la migration depuis Lab 5.

---

## 1. Pourquoi utiliser un StatefulSet pour les bases de données ?

Un **StatefulSet** est préférable à un Deployment pour les bases de données car :  

- Les pods ont **des identités stables** (`postgres-0`, `postgres-1`, …) et des **adresses DNS persistantes**.
- Chaque pod dispose de son **stockage persistant unique** via `volumeClaimTemplates`, ce qui garantit que les données ne sont pas perdues si le pod est recréé.
- Permet une **initialisation ordonnée** et un déploiement contrôlé des pods, utile pour la réplication et les mises à jour.

Contrairement à un Deployment, où les pods sont **interchangeables**, un StatefulSet conserve la **continuité des données et de la configuration**.

---

## 2. Migration de Lab 5 vers Lab 6

Étapes principales pour migrer les services de Lab 5 vers Lab 6 :

1. **Créer le namespace Lab 6** :
```bash
kubectl create namespace lab6
Q1 : How do volumeClaimTemplates work?

A1:

In a StatefulSet, each pod needs its own persistent storage.

volumeClaimTemplates define a template for PersistentVolumeClaims (PVCs) that Kubernetes will automatically create for each pod.

Each pod gets a unique PVC (e.g., postgres-data-postgres-0, postgres-data-postgres-1, …).

This ensures that data is persistent even if the pod is deleted or restarted.

Example in a StatefulSet YAML:

volumeClaimTemplates:
  - metadata:
      name: postgres-data
    spec:
      accessModes: ["ReadWriteOnce"]
      storageClassName: local-path
      resources:
        requests:
          storage: 5Gi

Q2 : How to scale the StatefulSet?

A2:

You can increase or decrease the number of replicas using the kubectl scale command:

kubectl scale statefulset postgres --replicas=3 -n lab6


Kubernetes will create new pods (postgres-1, postgres-2, …) with their own PVCs.

Each pod maintains its identity and persistent data, ensuring continuity.

Q3 : What are the DNS naming conventions for StatefulSets?

A3:

Each pod in a StatefulSet gets a stable DNS name:

<statefulset-name>-<ordinal>.<headless-service-name>.<namespace>.svc.cluster.local


Example:

postgres-0.postgres-headless.lab6.svc.cluster.local


This ensures pods are reachable in a predictable way and allows services to reliably connect to a specific pod.

Q4 : What are the rollback procedures?

A4:

If a deployment or StatefulSet update fails, you can rollback to the previous version:

kubectl rollout undo statefulset postgres -n lab6
kubectl rollout undo deployment web-deployment -n lab6


Verify pods and PVCs:

kubectl get pods -n lab6
kubectl get pvc -n lab6


PVCs are persistent, so database data is not lost during rollback.
