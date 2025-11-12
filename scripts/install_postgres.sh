#!/bin/bash
# =====================================
# Script: install_postgres.sh
# Description: Installe PostgreSQL et configure la base lab5db
# =====================================

echo "🚀 Installation de PostgreSQL..."
sudo apt update -y
sudo apt install -y postgresql postgresql-contrib

echo "✅ PostgreSQL installé."

echo "🚀 Démarrage du service..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "✅ PostgreSQL en cours d’exécution."
sudo systemctl status postgresql --no-pager
