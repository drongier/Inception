#!/bin/sh
set -e

echo "🗄️  Initialisation de MariaDB..."

# Vérifier que les variables d'environnement sont définies
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ]; then
    echo "Erreur : Variables d'environnement manquantes !"
    echo "Requis : MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD"
    exit 1
fi

# Vérifier si MariaDB est déjà initialisée
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "📦 Première initialisation de MariaDB..."
    
    # Initialiser le répertoire de données MariaDB
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
    
    echo "✅ MariaDB initialisée"
else
    echo "✅ MariaDB déjà initialisée"
fi

# Démarrer MariaDB temporairement en arrière-plan pour la configuration
echo "🔧 Configuration de la base de données..."
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

-- Supprimer les utilisateurs anonymes
DELETE FROM mysql.user WHERE User='';

-- Supprimer la base de données de test
DROP DATABASE IF EXISTS test;

-- Créer la base de données WordPress
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

-- Créer l'utilisateur WordPress
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Donner tous les droits à l'utilisateur WordPress sur sa base
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

-- Changer le mot de passe root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Appliquer les changements
FLUSH PRIVILEGES;
EOF

echo "✅ Base de données configurée"
echo "   📊 Base de données : ${MYSQL_DATABASE}"
echo "   👤 Utilisateur : ${MYSQL_USER}"

# Lancer MariaDB en mode normal
echo "🚀 Démarrage de MariaDB..."
exec mysqld --user=mysql --console
