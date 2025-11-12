#!/bin/bash
# =====================================
# Script: setup_database.sh
# Description: Crée la base de données et l'utilisateur lab5user
# =====================================

DB_NAME="lab5db"
DB_USER="lab5user"
DB_PASS="lab5pass"

echo "🚀 Création de la base de données et de l’utilisateur..."

sudo -u postgres psql <<EOF
CREATE DATABASE ${DB_NAME};
CREATE USER ${DB_USER} WITH ENCRYPTED PASSWORD '${DB_PASS}';
GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};
EOF

echo "✅ Base ${DB_NAME} et utilisateur ${DB_USER} créés avec succès."
