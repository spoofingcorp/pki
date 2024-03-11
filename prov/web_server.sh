#!/bin/bash

# Ajout des entrées dans /etc/hosts
echo "192.168.33.20 dns.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.21 pki.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.22 web.m2.dawan" | sudo tee -a /etc/hosts

# Mise à jour des paquets et installation d'Apache
sudo apt-get update
sudo apt-get install -y apache2

# Création du dossier de log pour Apache2 si non existant
sudo mkdir -p /var/log/apache2

# Création d'un fichier de configuration Apache pour web.m2.dawan
cat << EOF | sudo tee /etc/apache2/sites-available/web.m2.dawan.conf
<VirtualHost *:80>
    ServerName web.m2.dawan
    ServerAlias www.web.m2.dawan
    DocumentRoot /var/www/html

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Activation du site web.m2.dawan
sudo a2ensite web.m2.dawan.conf

# Désactivation du site par défaut
sudo a2dissite 000-default.conf

# Activation du module rewrite d'Apache
sudo a2enmod rewrite

# Redémarrage d'Apache pour appliquer les modifications
sudo systemctl reload apache2

# Installation de Certbot et du plugin Apache pour Certbot
sudo apt-get install -y certbot python3-certbot-apache

# Pré-configuration pour Certbot (Remplacer les valeurs selon votre domaine)
# IMPORTANT: Modifier "yourdomain.com" par votre domaine réel et configurer DNS ou /etc/hosts en conséquence
# sudo certbot --apache -d yourdomain.com -d www.yourdomain.com --register-unsafely-without-email --agree-tos

echo "Apache server setup completed."
