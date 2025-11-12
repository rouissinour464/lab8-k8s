#!/bin/bash
# =====================================
# Script: build_and_push.sh
# Description: Construit et pousse l’image Docker vers Docker Hub
# =====================================

IMAGE_NAME="nour292/lab5-web:latest"

echo "🚀 Construction de l’image Docker..."
cd ../app || exit
docker build -t lab5-web .

echo "🔄 Tagging de l’image..."
docker tag lab5-web nour292/lab5-web:latest
echo "🔑 Connexion à Docker Hub..."
docker login

echo "☁️ Push de l’image vers Docker Hub..."
docker push lab5-web nour292/lab5-web:latest
echo "✅ Image poussée avec succès sur Docker Hub ($IMAGE_NAME)"
